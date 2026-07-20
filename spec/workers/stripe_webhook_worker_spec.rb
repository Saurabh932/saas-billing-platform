require "rails_helper"

RSpec.describe StripeWebhookWorker, type: :worker do
    subject(:worker) { described_class.new }

    describe "#perform" do
        let(:account) { create(:account, stripe_customer: "cus_123") }
        let(:plan) { create(:plan) }

        let(:session_data) do
            {
                "customer" => account.stripe_customer,
                "subscription" => "sub_123",
                "created" => Time.current.to_i,
                "metadata" => {
                    "plan_id" => plan.id
                }
            }
        end

        context "when checkout.session.completed" do
            it "creates a subscription" do
                expect do
                    worker.perform(
                        "checkout.session.completed", session_data.to_json
                    )
                end.to change(Subscription, :count).by(1)

                subscription = Subscription.last

                expect(subscription.account).to eq(account)
                expect(subscription.plan).to eq(plan)
                expect(subscription.stripe_subscription_id).to eq("sub_123")
                expect(subscription.status).to eq("active")
            end
        end

        context "when  account does not exist" do
            before do
                session_data["customer"] = "cus_unknown"
            end

            it "does not create a subscription" do
                expect do
                    worker.perform(
                        "checkout.session.completed",
                        session_data.to_json
                    )
                end.not_to change(Subscription, :count)
            end
        end

        context "when plan does not exist" do
            before do
                session_data["metadata"]["plan_id"] = 999_999
            end

            it "does not create a subscription" do
                expect do
                    worker.perform(
                        "checkout.session.completed",
                        session_data.to_json
                    )
                end.not_to change(Subscription, :count)
            end
        end
    end
end
