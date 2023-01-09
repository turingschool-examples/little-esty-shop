require 'rails_helper'

RSpec.describe 'merchant item edit page' do
  it 'has a form that is prepopulated with existing item attribute info' do
    visit edit_merchant_item_path(1, 10)
    item = Item.find(10)

    expect(page).to have_field('item[name]', with: item.name)
    expect(page).to have_field('item[current_price]', with: item.unit_price_to_dollars)
    expect(page).to have_field('item[description]', with: item.description)
  end

  it 'updates the item when new info is entered on the form and submitted' do
    visit edit_merchant_item_path(1, 10)
    item = Item.find(10)

    fill_in 'item[name]', with: 'New item name'
    fill_in 'item[description]', with: 'Fancy item does fancy things'
    fill_in 'item[current_price]', with: '99.99'

    click_button 'Update Item'

    expect(current_path).to eq(merchant_item_path(1,10))
    expect(page).to have_content('New item name')
    expect(page).to_not have_content('Item Quidem Suscipit')
    expect(page).to have_content('Current Price: $99')
    expect(page).to_not have_content('Current Price: $340.18')
    expect(page).to have_content('Description: Fancy item does fancy things')
    expect(page).to_not have_content('Description: Reiciendis sed aperiam culpa animi laudantium. Eligendi veritatis sint dolorem asperiores. Earum alias illum eos non rerum.')
  end

  it 'does not update if missing attributes' do
    visit edit_merchant_item_path(1, 10)
    item = Item.find(10)

    fill_in 'item[name]', with: 'New item name'
    fill_in 'item[description]', with: ''
    fill_in 'item[current_price]', with: '99.99'

    click_button 'Update Item'
    
    expect(current_path).to eq(edit_merchant_item_path(1, 10))
    expect(page).to have_content('Error: All fields must be filled in')
  end

end

