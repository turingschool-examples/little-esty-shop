require 'rails_helper'

describe "Merchant Item Edit Page" do
  before do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
    @item_1 = @merchant_1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti", unit_price: 75107)
    @item_2 = @merchant_1.items.create!(name: "Autem Minima", description: "Cumque consequuntur ad", unit_price: 67076)
  end

  it "displays a form filled in with the items attributes" do
    visit edit_merchant_item_path(@merchant_1, @item_1)

    expect(find_field('Name').value).to eq("Qui Esse")
    expect(find_field('Description').value).to eq("Nihil autem sit odio inventore deleniti")
    expect(find_field('Unit Price').value).to eq(75107.to_s)

    expect(find_field('Name').value).to_not eq("Autem Minima")
  end

  it "can fill in form, submit, and redirect to the item's show page with updated info and a flash message" do
    visit edit_merchant_item_path(@merchant_1, @item_1)

    fill_in 'Name', with: 'A non latin name'
    fill_in 'Description', with: 'Wow I can actually read this'
    fill_in 'Unit Price', with: '67070'

    click_button "Update"

    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))

    expect(page).to have_content('A non latin name')
    expect(page).to have_content('Wow I can actually read this')
    expect(page).to have_content("$67,070.00")

    expect(page).to_not have_content("Qui Esse")
    expect(page).to have_content('You have successfully updated this item!')
  end

  it "shows a different flash message if not all sections are filled in" do

    visit edit_merchant_item_path(@merchant_1, @item_1)

    fill_in "Name", with: ""
    fill_in 'Description', with: 'Wow I can actually read this'
    fill_in 'Unit Price', with: '67070'

    click_button "Update"

    expect(current_path).to eq(edit_merchant_item_path(@merchant_1, @item_1))
    expect(page).to have_content('Please fill out all fields to update this item!')
  end
end
