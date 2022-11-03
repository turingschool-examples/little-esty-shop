require "rails_helper"


RSpec.describe("admin merchants SHOW page") do
  before(:each) do
    @merchant1 = Merchant.create!(    name: "Tokyos Tractors")
    @merchant2 = Merchant.create!(    name: "Oslos Outdoor Market")
    @merchant3 = Merchant.create!(    name: "Berlins Building Supply")
  end

  describe("26.When I visit a merchant's admin show page") do
    describe("Then I see a link to update the merchant's information.") do
      it("26.When I click the link,I am taken to a page to edit this merchant") do
        visit(admin_merchant_path(@merchant1.id))
        expect(page).to(have_link("Update Merchants Info"))
        click_link("Update Merchants Info")
        expect(current_path).to(eq(edit_admin_merchant_path(@merchant1.id)))
      end
    end
  end

  describe("I see a form filled in with the existing merchant attribute information") do
    it("26.When I update the information in the form and I click ‘submit’") do
      visit(admin_merchant_path(@merchant1.id))
      expect(page).to(have_link("Update Merchants Info"))
      click_link("Update Merchants Info")
      expect(current_path).to(eq(edit_admin_merchant_path(@merchant1.id)))

      within("#testing") do
        expect(page).to(have_field("name",         with: "Tokyos Tractors"))
        fill_in("name",         with: "Alexs Axles")
        click_button("Submit")
      end
    end
  end

  describe("I am redirected back to the merchant's admin show page where I see the updated information") do
    it("26.I see a flash message stating that the information has been successfully updated.") do
      visit(admin_merchant_path(@merchant1.id))
      expect(page).to(have_link("Update Merchants Info"))
      click_link("Update Merchants Info")
      expect(current_path).to(eq(edit_admin_merchant_path(@merchant1.id)))

      within("#testing") do
        expect(page).to(have_field("name",         with: "Tokyos Tractors"))
        fill_in("name",         with: "Alexs Axles")
        click_button("Submit")
        expect(current_path).to(eq(admin_merchant_path(@merchant1.id)))
      end
    end
  end
end
