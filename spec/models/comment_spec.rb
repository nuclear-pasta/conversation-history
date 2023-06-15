RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:subject).polymorphic }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
  end
end