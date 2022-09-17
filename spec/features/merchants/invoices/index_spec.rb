require "rails_helper"


RSpec.describe "the merchant items index"  do
    it "I see the name of my merchant"  do
        merchant1 = Merchant.create!(name: "Bob")

        visit "/merchants/#{merchant1.id}/invoices"
        expect(page).to have_content("#{merchant1.name} Invoices")
    end
end