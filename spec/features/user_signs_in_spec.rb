require 'rails_helper'

RSpec.describe 'logging in', type: :feature do
  context 'for an existing user' do
    let!(:user) { FactoryGirl.create(:user) }

    it 'returns a JWT' do
      visit '/login'

      fill_in 'Email',    with: user.email
      fill_in 'Password', with: user.password
      click_button 'Create Foobar'

      binding.pry

      expect(page).to have_css '.foobar-name', 'My foobar'
    end
  end
end
