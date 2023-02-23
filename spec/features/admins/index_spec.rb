require 'rails_helper'

RSpec.describe "The Admin Index" do
  before(:each) do
    visit "/admin"
  end

  describe "User Story 19" do
    it "When an admin the admin dashboard (/admin), they see a header indicating that they are on the admin dashboard" do 
      expect(page).to have_content("Admin Dashboard")
    end
  end

  describe "User Story 20" do
    it "When I visit the admin dashboard (/admin) then I see a link to the admin merchants index (/admin/merchants)
      and I see a link to the admin invoices index (/admin/invoices)" do

      expect(page).to have_link("Merchants", href: "/admin/merchants")
      expect(page).to have_link("Invoices", href: "/admin/invoices")
    end
  end
end