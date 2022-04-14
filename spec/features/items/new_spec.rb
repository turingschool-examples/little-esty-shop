require 'rails_helper'

describe 'merchant item index page' do
  before do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
      created_at: Date.current,
      updated_at: Date.current
    )

    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10000,
      created_at: Date.current,
      updated_at: Date.current
    )
    @soccer = @merchant_1.items.create!(
      name: "Soccer Ball",
      description: "A ball of pure soccer.",
      unit_price: 32000,
      created_at: Date.current,
      updated_at: Date.current
    )

    visit "/merchants/#{@merchant_1.id}/items"
  end

  it 'has a form to create a new item' do
    click_button("Create a New Item")
    expect(find('form')).to have_content('Name:')
    expect(find('form')).to have_content('Description:')
    expect(find('form')).to have_content('Price: $')
    expect(find('form')).to have_button('Create Item')
  end

  it 'redirects to the index which shows the new item' do
    click_button("Create a New Item")

    fill_in 'Name:', with: "Gundam"
    fill_in 'Description:', with: "Barbados Lupus"
    fill_in 'Price: $', with: "15099"
    click_button "Create Item"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

    expect(page).to have_content("Gundam")
    expect(page).to have_content("Barbados Lupus")
    expect(page).to have_content("Price: $150.99")
  end

  it "redirects to the new page if you don't enter all info" do
    click_button("Create a New Item")

    fill_in 'Name:', with: "Gundam"

    click_button "Create Item"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")

  end
end
