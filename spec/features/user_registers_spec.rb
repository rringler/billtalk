require 'rails_helper'

RSpec.describe 'registering', type: :feature do
  context 'when successful' do
    let(:user_attrs) { FactoryGirl.attributes_for(:user) }

    it 'creates a new User' do
      visit '/register'

      within('div.content') do
        fill_in 'email',    with: user_attrs[:email]
        fill_in 'password', with: user_attrs[:password]
        check   'tos'

        expect { click_button 'Submit' }.to change { User.count }.by(1)
      end
    end
  end
end
