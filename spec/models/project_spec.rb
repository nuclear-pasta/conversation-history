require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { should have_many(:comments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'state' do
    it { should define_enum_for(:state).with_values(draft: 0, submitted: 1, approved: 2, rejected: 3, cancelled: 4) }
    it { should allow_event(:submit).from(:draft).to(:submitted) }
    it { should allow_event(:approve).from(:submitted).to(:approved) }
    it { should allow_event(:reject).from(:submitted).to(:rejected) }
    it { should allow_event(:cancel).from(:draft, :submitted, :approved, :rejected).to(:cancelled) }
  end

end