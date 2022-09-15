require "rails_helper"


RSpec.describe("1.Merchant dashboard") do
  describe("visit my merchant dashboard") do
    it("I see the name of my merchant") do
      merchant1 = Merchant.create!(      name: "Bob")
      visit("/merchants/#{merchant1.id}/dashboard")
      expect(page).to(have_content("#{merchant1.name}"))
    end
  end

  #Merchant Dashboard Items Ready to Ship
  #As a merchant
  #When I visit my merchant dashboard
  #Then I see a section for "Items Ready to Ship"
  #In that section I see a list of the names of all of my items that
  #have been ordered and have not yet been shipped,
  #And next to each Item I see the id of the invoice that ordered my item
  #And each invoice id is a link to my merchant's invoice show page
  describe("4.visit my merchant dashboard") do
    it("I see a section for 'Items Ready to Ship'") do
      merchant1 = Merchant.create!(      name: "Bob")
      customer1 = Customer.create!(      first_name: "cx first name",       last_name: "cx last name")
      invoice1 = customer1.invoices.create!(      status: 1,       created_at: "2012-03-25 09:53:09")
      item1 = merchant1.items.create!(      name: "item1",       description: "this is item1 description",       unit_price: 1)
      invoice_item1 = InvoiceItem.create!(      item_id: item1.id,       invoice_id: invoice1.id,       unit_price: item1.unit_price,       quantity: 2,       status: 0)

      #transaction1 = invoice1.transactions.create!(      result: "success")
      visit("/merchants/#{merchant1.id}/dashboard")
      save_and_open_page
      expect(page).to(have_content("Items Ready to Ship"))
      expect(page).to(have_content("#{item1.name}"))
    end
  end
end
