require 'rails_helper'

RSpec.describe AccountSignupService do
    # describes the method we are testing
    describe '.call' do
        # valid params for the service
        context 'when valid params are provided' do
            # build params like they come from signup form
            let(:params) do {
                org_name: 'Amce Corp',
                subdomain: 'amce-co',
                first_name: 'John',
                last_name: 'Doe',
                email: 'john.doe@amce.com',
                password: 'password123',
                password_confirmation: 'password123'
            }
            end

            it 'returns success' do
                result = AccountSignupService.call(params)
                expect(result.success?).to eq(true)
            end

            it 'creates an account' do
                expect { AccountSignupService.call(params) }.to change(Account, :count).by(1)
            end

            it 'creates a user' do
                expect { AccountSignupService.call(params) }.to change(User, :count).by(1)
            end

            it 'assigns admin role to user' do
                result = AccountSignupService.call(params)
                expect(result.user.role).to eq('admin')
            end

            it 'links user to account' do
                result = AccountSignupService.call(params)
                expect(result.user.account).to eq(result.account)
            end
        end

        # invalid params
        context 'when invalid params are provided' do
            # missing email - invalid
            let(:invalid_params) do {
                org_name: '',
                subdomain: 'acme-corp',
                first_name: '',
                last_name: '',
                email: 'john@acme.com',
                password: 'password123',
                password_confirmation: 'password123'
            }
            end

            it 'returns failure' do
                result = AccountSignupService.call(invalid_params)
                expect(result.success?).to eq(false)
            end

            it 'returns error message' do
                result = AccountSignupService.call(invalid_params)
                expect(result.error).to be_present
            end

            # this test the transcation rollback
            it 'does not create account or user' do
                    expect { AccountSignupService.call(invalid_params) }.to change(Account, :count).by(0)
                                                                        .and change(User, :count).by(0)
            end
        end
    end
end
