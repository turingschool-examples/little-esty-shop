require "rails_helper"


RSpec.describe("admin merchants index page") do
  before(:each) do
    @merchant1 = Merchant.create!(    name: "Tokyos Tractors")
    @merchant2 = Merchant.create!(    name: "Oslos Outdoor Market")
    @merchant3 = Merchant.create!(    name: "Berlins Building Supply")
  end

  describe("24.admin merchants index") do
    it("24.displays name of each merchant in the system") do
      visit(admin_merchants_path)
      expect(page).to(have_content(@merchant1.name))
      expect(page).to(have_content(@merchant2.name))
      expect(page).to(have_content(@merchant3.name))
    end
  end

  describe("25.I click on the name of a merchant from the admin merchants index page,") do
    it("25.I am taken to that merchant's admin show page (/admin/merchants/merchant_id)") do
      visit(admin_merchants_path)
      click_link("#{@merchant1.name}")
      expect(current_path).to(eq(admin_merchant_path(@merchant1.id)))
      expect(page).to(have_content("Name:#{@merchant1.name}"))
    end

    it("And I see the name of that merchant") do
      visit(admin_merchants_path)
      click_link("#{@merchant1.name}")
      expect(current_path).to(eq(admin_merchant_path(@merchant1.id)))
      expect(page).to(have_content("Name:#{@merchant1.name}"))
    end
  end
end
