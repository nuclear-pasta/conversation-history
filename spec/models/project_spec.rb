require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:comments) }
  end

  describe 'validations' do
    it{ is_expected.to validate_presence_of(:name) }
   end

  describe 'state machine' do
    let(:project) { FactoryBot.build(:project) } # Assuming you're using FactoryBot for object creation

    it 'starts in the draft state' do
      expect(project).to be_draft
    end

    it 'transitions to the submitted state when su    it{ is_expected.to validate_presence_of(:body) }
    bmitted' do
      expect { project.submit }.to change { project.state }.from('draft').to('submitted')
    end

    it 'transitions to the approved state when approved' do
      project.submit
      expect { project.approve }.to change { project.state }.from('submitted').to('approved')
    end

    it 'transitions to the rejected state when rejected' do
      project.submit
      expect { project.reject }.to change { project.state }.from('submitted').to('rejected')
    end

    it 'transitions to the cancelled state from any other state' do
      project.submit
      expect { project.cancel }.to change { project.state }.to('cancelled')
    end
  end
end

