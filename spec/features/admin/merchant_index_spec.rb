require 'rails_helper'

RSpec.describe "Admin Merchant index page" do
  before(:each) do
    @parlour = Merchant.create!(name: 'Ice Cream Parlour', status: 0)
    @tattoo = Merchant.create!(name: 'Tattoo Shop', status: 1)
    @item_1 = @parlour.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
    @item_2 = @tattoo.items.create!(name: 'Back scratch', description: 'skirtch back', unit_price: 5, status: 1)
    @item_3 = @tattoo.items.create!(name: 'Pooper Scooper', description: 'holds doge poo', unit_price: 13)
    visit "admin/merchant"
  end

  it "had a list of all merchants names" do
    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_content(@parlour.name)
    expect(page).to have_content(@tattoo.name)
  end

  it "click on merchant name takes me to that merchants show page" do
    click_link "Ice Cream Parlour"

    expect(current_path).to eq ("/admin/merchant/#{@parlour.id}")
    expect(page).to have_content("Ice Cream Parlour")
  end

  it 'shows a button next to each merchant to enable or disable that merchant' do
    within("#disabled-merchant-#{@parlour.id}") do
      expect(page).to have_button("Enable")
    end

    within("#enabled-merchant-#{@tattoo.id}") do
      expect(page).to have_button("Disable")
    end
  end
end
