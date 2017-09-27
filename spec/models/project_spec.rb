require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'check associations' do
    it 'has many allocations' do
      assc = described_class.reflect_on_association(:allocations)
      expect(assc.macro).to eq :has_many
    end

    it 'has many tasks' do
      assc = described_class.reflect_on_association(:tasks)
      expect(assc.macro).to eq :has_many
    end
  end

  describe 'validations' do
    before(:each) do
      @project = build :project
    end

    it 'accepts the valid project name' do
      @project.name = 'Test Project'
      expect(@project).to be_valid
    end

    it 'does not allow blank name' do
      @project.name = ''
      expect(@project).to be_invalid
      expect(@project.errors[:name]).to include("can't be blank")
    end
  end
end
