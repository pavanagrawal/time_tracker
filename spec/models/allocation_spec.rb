require 'rails_helper'

RSpec.describe Allocation, type: :model do
  describe 'check associations' do
    it 'belongs to project' do
      assc = described_class.reflect_on_association(:project)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
