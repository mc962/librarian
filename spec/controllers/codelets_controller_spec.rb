require 'rails_helper'

RSpec.describe CodeletsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    codelet_payload = {
      codelet: {
        name: Faker::Games::Fallout.unique.name,
        description: Faker::Games::Fallout.faction,
        examples: Faker::Games::Fallout.quote,
        publicly_accessible: Faker::Boolean.boolean
      }  
    }

    context 'logged in' do
      context 'successful creation' do
        it 'creates a codelet and redirects to #show' do
          initial_codelets_count = Codelet.count
          log_in!
          post :create, params: codelet_payload
          final_codelets_count = Codelet.count
          
          expect(response).to redirect_to(codelet_path(codelet_payload[:codelet][:name].parameterize))
          expect(final_codelets_count).to be_equal(initial_codelets_count + 1)
        end
      end
      
      context 'unsuccessful creation' do
        it 'fails to create a codelet' do
          bad_codelet_payload = codelet_payload.deep_dup
          bad_codelet_payload[:codelet][:description] = nil
  
          initial_codelets_count = Codelet.count
          log_in!
          post :create, params: bad_codelet_payload
          final_codelets_count = Codelet.count
          
          expect(response).to have_http_status(:unprocessable_entity)
          expect(final_codelets_count).to be_equal(initial_codelets_count)
        end
      end
    end
    
    context 'not logged in' do
      it 'may not create a codelet when not logged in' do
          initial_codelet_count = Codelet.count
          post :create, params: codelet_payload
          final_codelet_count = Codelet.count
          
            expect(response).to redirect_to(codelets_path)
          expect(final_codelet_count).to eq(initial_codelet_count)
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      codelet = FactoryBot.create(:codelet)

      get :edit, params: { id: codelet.slug }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    let(:initial_codelet) { FactoryBot.create(:codelet) }
    context 'logged in' do
      context 'successful update' do
        it 'updates the codelet and redirects to #show' do
          updated_description = Faker::GreekPhilosophers.quote
  
          log_in!          
          patch :update, params: {
            id: initial_codelet.slug,
            codelet: {
              description: updated_description
            }
          }
          
          updated_codelet = Codelet.find(initial_codelet.slug)
  
          expect(response).to redirect_to(codelet_path(initial_codelet.slug))
          expect(updated_codelet.description).to eq(updated_description)
        end
  
        it 'changes the slug when the name is updated' do
          updated_name = Faker::GreekPhilosophers.name
          
          log_in!          
          patch :update, params: {
            id: initial_codelet.slug,
            codelet: {
              name: updated_name
            }
          }
  
          updated_codelet = Codelet.find_by(id: initial_codelet.id)
  
          expect(updated_codelet.name).to eq(updated_name)
          expect(updated_codelet.slug).to eq(updated_name.parameterize)
        end
      end
      
      context 'unsuccessful update' do
        it 'fails to update a codelet' do
          log_in!
          patch :update, params: {
            id: initial_codelet.slug,
            codelet: {
              description: nil
            }
          }
          
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    
    context 'not logged in' do
      it 'may not update codelet when not logged in' do
        updated_description = Faker::GreekPhilosophers.quote
  
          patch :update, params: {
            id: initial_codelet.slug,
            codelet: {
              description: updated_description
            }
          }

            expect(response).to redirect_to(codelets_path)
          expect(initial_codelet.description).to_no eq(updated_description)
      end
    end
  end

  describe "DELETE #destroy" do
    context 'logged in' do
      context 'successful destroy' do
        it 'destroys the codelet' do
          FactoryBot.create_list(:codelet, 3)
          dieing_codelet = Codelet.first
  
          initial_codelet_count = Codelet.count
          
          log_in!
          delete :destroy, params: {
            id: dieing_codelet.slug
          }
          final_codelet_count = Codelet.count
  
          expect(response).to redirect_to(codelets_path)
          expect(final_codelet_count).to be_equal(initial_codelet_count - 1)
        end
      end
  
      context 'unsuccessful destroy' do
        it 'fails to destroy the codelet' do
          FactoryBot.create_list(:codelet, 3)
  
          initial_codelet_count = Codelet.count
          
          log_in!
          delete :destroy, params: {
            # give a slug for something that does not exist in the database, which should cause a failure
            id: Faker::Ancient.god.parameterize
          }
          final_codelet_count = Codelet.count
  
          expect(response).to redirect_to(codelets_path)
          expect(final_codelet_count).to be_equal(initial_codelet_count)
        end
      end
    end
    
    context 'not logged in' do
      it 'may not delete codelet when not logged in' do
        FactoryBot.create_list(:codelet, 3)
        
        dieing_codelet = Codelet.first
  
        initial_codelet_count = Codelet.count
        delete :destroy, params: {
          id: dieing_codelet.slug
        }
        final_codelet_count = Codelet.count

          expect(response).to redirect_to(codelets_path)
        expect(final_codelet_count).to be_equal(initial_codelet_count)
      end
    end
  end
end
