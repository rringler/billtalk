require 'rails_helper'

RSpec.describe 'signing up', type: :feature do
  context 'when successful' do
    let(:user_attrs) { FactoryBot.attributes_for(:user) }

    before { expect(User.count).to eq(0) }

    it 'creates a new User' do
      visit '/signup'

      within('form#users-new') do
        fill_in 'email',    with: user_attrs[:email]
        fill_in 'password', with: user_attrs[:password]
        check   'tos'

        click_button 'Submit'
      end

      expect(page).to have_current_path('/')
      expect(User.count).to eq(1)
    end
  end

  context 'when unsuccessful' do
    let!(:user) { FactoryBot.create(:user) }

    before { expect(User.count).to eq(1) }

    it 'does not create a new User' do
      visit '/signup'

      within('form#users-new') do
        fill_in 'email',    with: user.email
        fill_in 'password', with: user.password
        check   'tos'

        click_button 'Submit'
      end

      expect(page).to_not have_current_path('/')
      expect(User.count).to eq(1)
    end
  end
end
