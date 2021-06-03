require 'rails_helper'

RSpec.describe "items show page" do
  before :each do
    @merchant_1 = Merchant.create!( name:"Clothing")
    @item_1       = @merchant_1.items.create!( name:"Boots",
                                        description: "Leather",
                                        unit_price: 50,
                                        enabled: true
                                      )
  end

  it "displays the item and its attributes" do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"
    save_and_open_page

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.unit_price)
  end
end
