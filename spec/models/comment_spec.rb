RSpec.describe Comment, type: :model do
  describe 'associations' do
    it{ is_expected.to belong_to(:author) }
    it{ is_expected.to belong_to(:subject) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
  end
end