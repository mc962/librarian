require 'rails_helper'

RSpec.describe BasicSessionsController, type: :controller do
    describe 'POST #create' do
        context 'sucessful login' do
            it 'allows the user access' do
                post :create, params: { basic_sessions: { password: Rails.application.credentials.simple_authentication_key } }
                expect(flash[:success]).to eq('Validated!')
            end
        end

        context 'unsuccessful login' do
            it 'does not allow the user access' do
                post :create, params: { basic_sessions: { password: 'nope' } }
                expect(flash[:danger]).to eq('Problem validating...')
            end
        end
    end
end
