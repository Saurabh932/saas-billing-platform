class SubscriptionsController < ApplicationController
    def create
        plan = Plan.find(params[:plan_id])

        result = StripeCheckoutService.call(
            account: current_user.account,
            plan: plan
        )

        if result.success?
            redirect_to result.checkout_url, allow_other_host: true
        else
            redirect_to plans_path, alert: "Unable to start the checkout proccess."
        end
    end
end
