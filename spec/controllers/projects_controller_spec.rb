require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:draft_project) { create(:project) }
  let(:submitted_project) { create(:project, state: 'submitted') }

  let(:staff_user) { create(:user, staff: true) }
  let(:non_staff_user) { create(:user, staff: false) }

  def project_for_action(action)
    case action
    when 'submit', 'cancel'
      draft_project
    when 'approve', 'reject'
      submitted_project
    end
  end

  ['submit', 'approve', 'reject', 'cancel'].each do |action|
    describe "PUT ##{action}" do
      let(:project) { project_for_action(action) }

      context 'when user is a staff' do
        before do
          sign_in staff_user
        end

        it "changes project's state to #{action}" do
          put action, params: { id: project.id }
          expect(response).to redirect_to(project)
          expect(flash[:notice]).to eq("Project state is now: #{project.reload.state}")
        end
      end

      context 'when user is not a staff' do
        before do
          sign_in non_staff_user
        end

        it 'raises a CanCan::AccessDenied error' do
          expect { put action, params: { id: project.id } }.to raise_error(CanCan::AccessDenied)
        end
      end

      context 'when state change fails' do
        before do
          sign_in staff_user
          allow_any_instance_of(Project).to receive("#{action}!").and_return(false)
        end

        it "doesn't change project's state" do
          previous_state = project.state
          put action, params: { id: project.id }
          expect(response).to redirect_to(project)
          expect(flash[:alert]).to eq("Failed to change project state using action '#{action}'.")
          expect(project.reload.state).to eq(previous_state)
        end
      end
    end
  end
end
