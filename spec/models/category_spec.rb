require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'check associations' do
    it 'has many children' do
      assc = described_class.reflect_on_association(:children)
      expect(assc.macro).to eq :has_many
    end

    it 'has many time_trackers' do
      assc = described_class.reflect_on_association(:time_trackers)
      expect(assc.macro).to eq :has_many
    end

    it 'belongs to parent' do
      assc = described_class.reflect_on_association(:parent)
      expect(assc.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    before(:each) do
      @category = build :category
    end

    it 'accepts the valid project name' do
      @category.name = 'Test Project'
      expect(@category).to be_valid
    end

    it 'does not allow blank name' do
      @category.name = ''
      expect(@category).to be_invalid
      expect(@category.errors[:name]).to include("can't be blank")
    end
  end
end
