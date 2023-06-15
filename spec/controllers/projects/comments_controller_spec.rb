# spec/controllers/projects/comments_controller_spec.rb
require 'rails_helper'

RSpec.describe Projects::CommentsController, type: :controller do
  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project) }

    before do
      sign_in user
    end

    context 'with valid parameters' do
      let(:valid_params) { { project_id: project.id, comment: { content: 'Test comment' } } }

      it 'creates a new comment' do
        expect {
          post :create, params: valid_params
        }.to change(Comment, :count).by(1)
      end

      it 'assigns the current user as the comment author' do
        post :create, params: valid_params
        expect(Comment.last.author).to eq(user)
      end

      it 'redirects to the project show page with a success notice' do
        post :create, params: valid_params
        expect(response).to redirect_to(project)
        expect(flash[:notice]).to eq('Comment created successfully.')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { project_id: project.id, comment: { content: '' } } }

      it 'does not create a new comment' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Comment, :count)
      end

      it 'redirects to the project show page with an error message' do
        post :create, params: invalid_params
        expect(response).to redirect_to(project)
        expect(flash[:notice]).to eq('Comment was not saved.')
      end
    end
  end
end
