require 'rails_helper'

RSpec.describe TimeTracker, type: :model do
  describe 'check associations' do
    it 'belongs to category' do
      assc = described_class.reflect_on_association(:category)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to task' do
      assc = described_class.reflect_on_association(:task)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
