require 'rails_helper'

RSpec.describe 'signing in', type: :feature do
  context 'via the /login route' do
    context 'when successful' do
      let(:user) { FactoryGirl.create(:user) }

      it 'redirects to the root url' do
        visit '/login'

        within('form#login') do
          fill_in 'email',    with: user.email
          fill_in 'password', with: user.password

          click_button 'Submit'
        end

        expect(page).to have_current_path('/')
      end
    end

    context 'when unsuccessful' do
      let(:user) { FactoryGirl.build(:user) }

      it 'shows an error alert' do
        visit '/login'

        within('form#login') do
          fill_in 'email',    with: user.email
          fill_in 'password', with: user.password

          click_button 'Submit'
        end

        expect(page).to have_current_path('/login')
        expect(page).to have_css('div.alert.alert-danger')
      end
    end
  end

  context 'via the Navbar' do
    context 'when successful' do
      let(:user) { FactoryGirl.create(:user) }

      it 'rerenders with the logged in menubar items' do
        visit '/'

        click_link 'Login'

        within('form#login-compact') do
          fill_in 'email',    with: user.email
          fill_in 'password', with: user.password

          click_button 'Submit'
        end

        expect(page).to_not have_link('Login')
        expect(page).to     have_link('Logout')
      end
    end

    context 'when unsuccessful' do
      let(:user) { FactoryGirl.build(:user) }

      it 'does not rerender with the logged in menubar items' do
        visit '/'

        click_link 'Login'

        within('form#login-compact') do
          fill_in 'email',    with: user.email
          fill_in 'password', with: user.password

          click_button 'Submit'
        end

        expect(page).to     have_link('Login')
        expect(page).to_not have_link('Logout')
      end
    end
  end
end
