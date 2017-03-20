require 'rails_helper'

RSpec.describe 'signing in', type: :feature do
  context 'via the /login route' do
    context 'when successful' do
      let!(:user) { FactoryGirl.create(:user) }

      it 'redirects to the root url' do
        visit '/login'

        within('div.content') do
          fill_in 'email',    with: user.email
          fill_in 'password', with: user.password

          click_button 'Submit'
        end

        expect(page).to have_current_path('/')
      end
    end

    context 'when unsuccessful' do
      it 'redirects to the root url' do
        visit '/login'

        within('div.content') do
          fill_in 'email',    with: user.email
          fill_in 'password', with: user.password

          click_button 'Submit'
        end

        expect(page).to have_css('div.errors')
      end
    end
  end

  context 'via the Navbar' do
    context 'when successful' do
      let!(:user) { FactoryGirl.create(:user) }

      it 'redirects to the root url' do
        visit '/'

        click_link 'Login'

        within('div#login-compact') do
          fill_in 'email',    with: user.email
          fill_in 'password', with: user.password

          click_button 'Submit'
        end

        expect(page).to have_current_path('/')
      end
    end

    context 'when unsuccessful' do
      pending
    end
  end
end
