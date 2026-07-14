namespace :plans do
    desc "you description here"
    task seed: :environment do
        puts "===== STARTING PLAN SEED ====="

        plans = [
            {
                name: "Basic",
                price_cents: 900,
            interval: :month,~
                stripe_price_id: "price_1TtCBRByTjGWFMUpplyxcfOX",
                features: [
                            "Up to 3 projects",
                            "5 GB storage",
                            "Email support"
                           ],
                status: :active
            },
            {
                name: "Pro",
                price_cents: 2900,
                interval: :month,
                stripe_price_id: :price_pro,
                features: [
                            "Unlimited projects",
                            "100 GB storage",
                            "Priority email support",
                            "Team collaboration"
                           ],
                status: :active
            },
            {
                name: "Enterprise",
                price_cents: 9900,
                interval: :month,
                stripe_price_id: :price_enterprise,
                features: [
                            "Unlimited everything",
                            "Dedicated account manager",
                            "24/7 priority support",
                            "Advanced analytics",
                            "Custom integrations"
                           ],
                status: :active
            }
        ]

        plans.each do |plan_attrs|
            plan = Plan.find_or_initialize_by(name: plan_attrs[:name])
            plan.update!(plan_attrs)

            puts "✓ #{plan.name} plan created/updated"
        end

        puts "Done!"
    end
end
