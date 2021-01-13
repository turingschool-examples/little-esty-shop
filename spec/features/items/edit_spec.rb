require 'rails_helper'

describe "merchant items edit page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
  end

  it "sees a form filled in with the items attributes" do
    visit edit_merchant_item_path(@merchant1, @item_1)

    expect(find_field('Name').value).to eq(@item_1.name)
    expect(find_field('Description').value).to eq(@item_1.description)
    expect(find_field('Unit price').value).to eq(@item_1.unit_price.to_s)

    expect(find_field('Name').value).to_not eq(@item_2.name)
  end

  it "can fill in form, click submit, and redirect to that item's show page and see updated info and flash message" do
    visit edit_merchant_item_path(@merchant1, @item_1)

    fill_in "Name", with: "Bar Shampoo"
    fill_in "Description", with: "Eco friendly shampoo"
    fill_in "Unit price", with: "15"

    click_button "Submit"

    expect(current_path).to eq(merchant_item_path(@merchant1, @item_1))
    expect(page).to have_content("Bar Shampoo")
    expect(page).to have_content("Eco friendly shampoo")
    expect(page).to have_content("15")
    expect(page).to have_no_content("This washes your hair")
    expect(page).to have_content("Succesfully Updated Item Info!")
  end
  it "shows a flash message if not all sections are filled in" do
    visit edit_merchant_item_path(@merchant1, @item_1)

    fill_in "Name", with: ""
    fill_in "Description", with: "Eco friendly shampoo"
    fill_in "Unit price", with: "15"

    click_button "Submit"
    
    expect(current_path).to eq(edit_merchant_item_path(@merchant1, @item_1))
    expect(page).to have_content("All fields must be completed, get your act together.")
  end
end
