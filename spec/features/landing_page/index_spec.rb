require 'rails_helper'

RSpec.describe 'landing page', type: :feature do
  it 'landing page has title, new user button, and links' do
    u1 = User.create!(name: 'Sean', email: 'championlyfe@gmail.com')
    u2 = User.create!(name: 'Volk', email: 'primeathlete@gmail.com')
    u3 = User.create!(name: 'Izzy', email: 'animeever@gmail.com')

    visit root_path

    expect(page).to have_content('Viewing Party!')
    expect(page).to have_button('New User')

    expect(page).to have_link('Landing Page')

    within('#users') do
      expect(page).to have_link(u1.name.to_s)
      expect(page).to have_link(u2.name.to_s)
      expect(page).to have_link(u3.name.to_s)

      click_link(u1.name.to_s)

      expect(current_path).to eq(user_path(u1))
    end

    click_link('Landing Page')

    expect(current_path).to eq(root_path)

    click_button('New User')

    expect(current_path).to eq(new_user_path)
  end
end
