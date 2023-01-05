require 'rails_helper'

RSpec.describe 'Item creation' do
  it 'from the index page a link leads to a form that will create a new item and redirect back to the index page' do
    visit merchant_items_path(1)

    expect(page).to have_link("New Item", href: new_merchant_item_path(1))
    click_link("New Item")

    expect(current_path).to eq(new_merchant_item_path(1))
    fill_in 'Name', with: 'New item name'
    fill_in 'Description', with: 'Fancy item does fancy things'
    fill_in 'current_price', with: '99.99'

    click_button 'Submit'

    expect(current_path).to eq(merchant_items_path(1))
    within 'div#disabled' do
      expect(page).to have_content('New item name')
    end
  end
end