class StripeWebhookWorker
    include Sidekiq::Worker

    def perform(event_type, session_json)
        data = JSON.parse(session_json)

        case event_type
        when "checkout.session.completed"
            handle_checkout_completed(data)

        when "invoice.payment_failed"
            handle_payment_failed(data)

        when "customer.subscription.deleted"
            handle_subscription_deleted(data)
        end
    end

    private
    def handle_checkout_completed(session)
        account = Account.find_by(stripe_customer: session["customer"])
        return unless account

        plan = Plan.find_by(id: session.dig("metadata", "plan_id"))
        return unless plan

        Subscription.create!(
            account: account,
            plan: plan,
            stripe_subscription_id: session["subscription"],
            status: :active,
            current_period_start: Time.at(session["created"]),
            current_period_end: Time.at(session["created"]) + 30.days
        )
    end

    def handle_payment_failed(invoice)
        subscription = Subscription.find_by(stripe_subscription_id: invoice["subscription"])
        return unless subscription

        subscription.update!(status: :past_due)
    end

    def handle_subscription_deleted(subscription_data)
        subscription = Subscription.find_by(stripe_subscription_id: subscription_data["id"])
        return unless subscription

        subscription.update!(status: :cancelled, cancelled_at: Time.current)
    end
end
