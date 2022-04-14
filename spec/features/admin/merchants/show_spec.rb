require 'rails_helper'
require 'rspec'

describe "admin/merchant/show page" do
  before (:each) do
    @kilback = Merchant.create!(name: "Kilback Inc")

    visit "admin/merchants/#{@kilback.id}"

  end
  describe "when I visit the admin/merchant/show page" do
    it "displays the name of the merchant" do
      expect(page).to have_content("Kilback Inc")
    end

    it "displays a link to update the merchant" do
      expect(page).to have_link("Update #{@kilback.name}")
    end
  end

  describe "when I click on the update link" do
    it "takes me to a page to updat the merchant" do
      click_on "Update #{@kilback.name}"

      expect(current_path).to eq("admin/merchants/#{@kilback.id}/edit")
    end
  end
end
