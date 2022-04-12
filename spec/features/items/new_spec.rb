require 'rails_helper'

RSpec.describe 'the new merchant items form' do
  it 'I see a link to create a new item, when I click on the link I am taken to a form that allows me to add item information, when I click submit I am taken back to the items index page, and I see that my item was created with a default status of disabled' do
    merchant_1 = create(:merchant)

    visit "/merchants/#{merchant_1.id}/items"

    click_link 'New Item'

    fill_in 'Name', with: 'Big red clown noses'
    fill_in 'Description', with: 'Clown noses, big and red'
    fill_in 'Unit Price', with: 1399
    click_button 'Submit'

  expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
    expect(page).to have_content('Big red clown noses')
    expect(page).to have_content('Clown noses, big and red')
    expect(page).to have_content(1399)
    expect(page).to have_content('Disabled')

  end
end
