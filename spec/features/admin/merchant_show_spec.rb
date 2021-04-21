require 'rails_helper'

RSpec.describe "Admin Merchant Show page" do
  before(:each) do
    @parlour = Merchant.create!(name: 'Ice Cream Parlour', status: 0)
    @tattoo = Merchant.create!(name: 'Tattoo Shop', status: 0)
    visit "/admin/merchant/#{@parlour.id}"
  end

  it "Merchants show page" do
    expect(page).to have_content("Ice Cream Parlour")
    expect(page).to_not have_content("Tattoo")
  end

    it "Shows that merchants name and a link to update" do
      expect(page).to have_content(@parlour.name)
      expect(page).to have_link("Update")
      expect(page).to_not have_content(@tattoo.name)
    end
end
