require 'rails_helper'

RSpec.describe "Admin Merchant Show page" do
  before(:each) do
    @parlour = Merchant.create!(name: 'Ice Cream Parlour')
    @tattoo = Merchant.create!(name: 'Tattoo Shop')
    visit "/admin/merchant/#{@parlour.id}"
  end

    it "Shows that merchants name and a link to update" do
      expect(page).to have_content(@parlour.name)
      expect(page).to have_link("Update")
      expect(page).to_not have_content(@tattoo.name)
    end
end
