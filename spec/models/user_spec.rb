require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    before(:each) do
      @user = build :user
    end

    it 'does not allow blank email' do
      @user.email = ''
      expect(@user).to be_invalid
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'checks uniqueness of email' do
      @user.save
      user2 = build :user, email: @user.email

      expect(user2).to be_invalid
      expect(user2.errors[:email]).to include('has already been taken')
    end

    it 'does not allow blank password' do
      @user.password = ''
      expect(@user).to be_invalid
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'validates the length of the password' do
      @user.password = 'abd'
      expect(@user).to be_invalid
      expect(@user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end

  describe 'current week projects' do
    let(:today) {Date.today}
    let!(:user) {create :user}
    let!(:projects) {create_list(:project, 10)}

    context 'when project fall under the current week' do
      before(:each) {
        projects.each do |p|
          create(:allocation, user: user, project: p, start_date: today.at_beginning_of_week, end_date: today.at_end_of_week)
        end
      }

      it 'returns the projects of current week' do
        expect(user.current_week_projects.pluck(:id)).to eq(projects.pluck(:id))
      end
    end

    context 'when project does not fall under the current week' do
      before(:each) {
        projects.each do |p|
          create(:allocation, user: user, project: p, start_date: today.at_beginning_of_week + 1, end_date: today.at_end_of_week - 1)
        end
      }

      it 'does not return any project for current week' do
        expect(user.current_week_projects.pluck(:id)).to be_empty
      end
    end

    context 'when projects fall under the current week partially' do
      before(:each) {
        projects.each_with_index do |p, i|
          if i <= 4
            start_date = today.at_beginning_of_week + 1
            end_date = today.at_end_of_week - 1
          else
            start_date = today.at_beginning_of_week
            end_date = today.at_end_of_week
          end

          create(:allocation, user: user, project: p, start_date: start_date, end_date: end_date)
        end
      }

      it 'does not return any project for current week' do
        expect(user.current_week_projects.pluck(:id).size).to eq(5)
      end
    end
  end

  describe 'name' do
    let(:user) { create :user }

    it 'returns the email as name' do
      expect(user.name).to eq(user.email)
    end
  end
end
