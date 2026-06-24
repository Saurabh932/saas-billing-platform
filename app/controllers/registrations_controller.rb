class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [ :create ]

    def create
        result = AccountSignupService.call(sign_up_params.merge(account: params[:account]))

        if result.success?
            sign_in(result.user)
            redirect_to root_path, notice: "Account created successfully."

        else
            flash.now[:alert] = result.error
            render :new, status: :unprocessable_entity
        end
    end

    protected
    def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, account: [ :org_name, :subdomain ] ])
    end
end
