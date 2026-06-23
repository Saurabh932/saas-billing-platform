require 'ostruct'

class AccountSignupService
    def self.call(params)
        new(params).call
    end

    def initialize(params)
        @params = params
    end

    def call
        ActiveRecord::Base.transaction do
            account = Account.create!(name: @params[:org_name],
                                      subdomain: generate_subdomain(@params[:org_name]),
                                      email: @params[:email],
                                      status: :active)

            user = account.users.create!(first_name: @params[:first_name],
                                         last_name: @params[:last_name],
                                         email: @params[:email],
                                         password: @params[:password],
                                         password_confirmation: @params[:password_confirmation],
                                         role: :admin)

            OpenStruct.new(success?: true,
                           user: user,
                           account: account,
                           error: nil)
        end

    rescue ActiveRecord::RecordInvalid => e
        OpenStruct.new(success?: false,
                        user: nil,
                        account: nil,
                        error: e.message)
    end

    private
    def generate_subdomain(org_name)
        org_name.downcase.gsub(/[^a-z0-9\s]/, "").gsub(/\s+/, "-")
    end
end
