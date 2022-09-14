require "rails_helper"


RSpec.describe("Merchant dashboard") do
  describe("visit my merchant dashboard") do
    it("I see the name of my merchant") do
      merchant1 = Merchant.create!(      name: "Bob")
      visit("/merchants/#{merchant1.id}/dashboard")
      expect(page).to(have_content("#{merchant1.name}"))
    end
  end
end
