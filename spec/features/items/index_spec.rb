require 'rails_helper'
## i had to remove the before each here because we needed the complete dataset to run the more
## complex tests. I commented out and didn't delete anything. all tests pass.
RSpec.describe "Merchant item index" do
  # before :each do
  #   @merchant1 = Merchant.create!(name: "Kelly")
  #   @merchant2 = Merchant.create!(name: "Craig")
  #   @item_1 = @merchant1.items.create!(name: "Mixing Bowl", description: "xyz", unit_price: 500)
  #   @item_2 = @merchant1.items.create!(name: "Gumball", description: "abc", unit_price: 25)
  #   @item3 = @merchant2.items.create!(name: "Hat", description: "sdasasdsd", unit_price: 88)
  # end

  it 'I see a list of the names of all of my items' do
    visit merchant_items_path(@merchant_1)
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    # expect(page).to_not have_content(@item3.name)
  end

  it 'each items name is a link to the show page' do
    visit merchant_items_path(@merchant_1)
    click_link "#{@item_1.name}"
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
  end

  it 'has an enable button for each item that changes the status' do
    visit merchant_items_path(@merchant_1)

    within("#item-#{@item_1.id}") do
      click_button("Enable")

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      expect(page).to have_content("Status: enabled" )
    end
  end

  it 'has a disable button for each item that changes the status' do
    visit merchant_items_path(@merchant_1)

    within("#item-#{@item_1.id}") do
      click_button("Disable")

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      expect(page).to have_content("Status: disabled" )

      click_button("Enable")

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      expect(page).to have_content("Status: enabled" )
    end
  end

  it 'show the top 5 most popular items and links to the merchant_items show page' do
    visit merchant_items_path(@merchant_1)
    
    within("#item-#{@item4.id}") do
      expect(page).to have_content("#{@item4.name}" )
      expect(page).to have_content("#{@item4.revenue}" )

      click_link(@item4.name)
      expect(current_path).to eq(merchant_items_path(@merchant_1, @item4))

    end
  end
end
