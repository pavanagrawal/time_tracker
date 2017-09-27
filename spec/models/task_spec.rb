require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'check associations' do
    it 'belongs to project' do
      assc = described_class.reflect_on_association(:project)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
