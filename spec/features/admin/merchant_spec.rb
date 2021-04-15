require 'rails_helper'

RSpec.describe "Admin Merchant index page" do
  before(:each) do
    @parlour = Merchant.create!(name: 'Ice Cream Parlour')
    @tattoo = Merchant.create!(name: 'Tattoo Shop')
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
end
