# spec/models/ability_spec.rb
require 'rails_helper'

RSpec.describe Ability, type: :model do
  describe 'user abilities' do
    let(:user) { FactoryBot.create(:user) }
    let(:ability) { Ability.new(user) }

    context 'when user is a staff' do
      let(:user) { FactoryBot.create(:user, staff: true) }

      it 'allows submitting, approving, rejecting, and canceling projects' do
        expect(ability.can?(:submit, Project)).to be true
        expect(ability.can?(:approve, Project)).to be true
        expect(ability.can?(:reject, Project)).to be true
        expect(ability.can?(:cancel, Project)).to be true
      end

      it 'denies other actions on projects' do
        expect(ability.can?(:read, Project)).to be true
        expect(ability.can?(:create, Project)).to be false
        expect(ability.can?(:update, Project)).to be false
        expect(ability.can?(:destroy, Project)).to be false
      end
    end

    context 'when user is not a staff' do
      it 'allows reading projects' do
        expect(ability.can?(:read, Project)).to be true
      end

      it 'denies other actions on projects' do
        expect(ability.can?(:create, Project)).to be false
        expect(ability.can?(:update, Project)).to be false
        expect(ability.can?(:destroy, Project)).to be false
      end
    end
  end
end
