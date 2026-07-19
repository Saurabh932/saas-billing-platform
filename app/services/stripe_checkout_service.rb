class StripeCheckoutService
    Result = Struct.new(:success?, :checkout_url, :error)

    def self.call(account:, plan:)
        new(account, plan).call
    end

    def initialize(account, plan)
        @account = account
        @plan = plan

        Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
    end

    def call
        session = Stripe::Checkout::Session.create(
            mode: "subscription",
            customer: @account.stripe_customer,
            line_items: [ {
                price: @plan.stripe_price_id,
                quantity: 1
            } ],
            metadata: {
                plan_id: @plan.id
            },
            success_url: success_url,
            cancel_url: cancel_url
        )

        Result.new(true, session.url, nil)
    rescue Stripe::StripeError => e
        Result.new(false, nil, e.message)
    end

    private

    def success_url
        "http://localhost:3000/dashboard"
    end

    def cancel_url
        "http://localhost:3000/plans"
    end
end
