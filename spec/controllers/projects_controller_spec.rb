# spec/controllers/projects_controller_spec.rb
require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'assigns the project and comments' do
      get :show, params: { id: project.id }
      expect(assigns(:project)).to eq(project)
      expect(assigns(:comments)).to eq(project.comments)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(200)
    end
  end

  ['submit', 'approve', 'reject', 'cancel'].each do |action|
    describe "PUT ##{action}" do
      context 'when user is authorized' do
        before do
          allow(controller).to receive(:authorize!).and_return(true)
          allow(project).to receive(action).and_return(true)
        end

        it "changes project's state to #{action}" do
          put action, params: { id: project.id }
          expect(response).to redirect_to(project)
          expect(flash[:notice]).to eq("Project state is now: #{project.state}")
        end
      end

      context 'when user is not authorized' do
        before do
          allow(controller).to receive(:authorize!).and_raise(CanCan::AccessDenied)
        end

        it 'redirects to root path with alert' do
          put action, params: { id: project.id }
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq('You are not authorized to perform this action.')
        end
      end

      context 'when state change fails' do
        before do
          allow(controller).to receive(:authorize!).and_return(true)
          allow(project).to receive(action).and_return(false)
        end

        it "doesn't change project's state" do
          put action, params: { id: project.id }
          expect(response).to redirect_to(project)
          expect(flash[:alert]).to eq("Failed to change project state using action '#{action}'.")
        end
      end
    end
  end
  
end
