class WebhookaController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_url

    before_action :verify_stripe_signature

    def stripe
        case @event.type
        when "checkout.session.completed"
            handle_checkout_completed(@event.data.object)

        when "invoice.payment_failed"
            handle_payment_falled(@event.data.object)

        when "customer.subscription.deleted"
            handle_subscription_deleted(@event.data.object)
        end

        render json: { message: "success" }, status: :ok
    end

    private
    def verify_stripe_signature
        payload = request.body.read
        sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
        webhook_secret = ENV["STRIPE_WEBHOOK_SECRET"]

        begin
            @event = Stripe::Webhook.construct_event(
                payload, sig_header, webhook_secret
            )
        rescue JSON::PraserError => e
            render json: { error: "Invalid payload" }, status: :bad_request
        rescue Stripe::SignatureVerificationError => e
            render json: { error: "Invalid signature" }, status: :unauthorized
        end
    end

    def handle_checkout_completed(session)
        StripeWebhookWorker.perform_async("checkout.session.completed", session.to_json)
    end

    def handle_payment_failed(invoice)
        StripeWebhookWorker.perform_async("invoice.payment_failed", invoice.to_json)
    end

    def handle_subscription_deleted(subscription)
        StripeWebhookWorker.perform_async("customer.subscription.deleted", subscription.to_json)
    end
end
