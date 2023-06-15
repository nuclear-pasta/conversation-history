require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'Devise modules' do
    it { should be_validatable }
    it { should be_database_authenticatable }
    it { should be_recoverable }
    it { should be_rememberable }
  end
end
