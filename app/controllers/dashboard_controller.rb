class DashboardController < ApplicationController
    def index
        @account = current_user.account
        @subscription = @account.subscriptions.where(status: "active").last
    end
end
