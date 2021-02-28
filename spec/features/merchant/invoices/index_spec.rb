require 'rails_helper'

RSpec.describe "Merchant invoice index page" do
  before :each do
    @customer = Customer.create!(first_name: "First1", last_name: "Last1")
    @invoice1 = @customer.invoices.create!(status: 1)
    @invoice2 = @customer.invoices.create!(status: 1)
    @invoice3 = @customer.invoices.create!(status: 1)
    @invoice4 = @customer.invoices.create!(status: 1)
    @invoice5 = @customer.invoices.create!(status: 1)

    @merchant1 = Merchant.create!(name: "Merchant1")
    @item1 = @merchant1.items.create!(name: "Item1", description: "Description1", unit_price: 2)
    @item2 = @merchant1.items.create!(name: "Item2", description: "Description2", unit_price: 3)
    @item3 = @merchant1.items.create!(name: "Item1", description: "Description1", unit_price: 2)

    @merchant2 = Merchant.create!(name: "Merchant1")
    @item4 = @merchant2.items.create!(name: "Item1", description: "Description1", unit_price: 2)

    @invoice1_item1 = InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 1, status: 0)

    @invoice2_item2 = InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 2, unit_price: 2, status: 1)
    @invoice2_item3 = InvoiceItem.create!(item: @item3, invoice: @invoice2, quantity: 1, unit_price: 1, status: 0)

    @invoice3_item4 = InvoiceItem.create!(item: @item4, invoice: @invoice3, quantity: 2, unit_price: 2, status: 1)
    @invoice3_item1 = InvoiceItem.create!(item: @item1, invoice: @invoice3, quantity: 1, unit_price: 1, status: 0)

    @invoice4_item4 = InvoiceItem.create!(item: @item4, invoice: @invoice4, quantity: 2, unit_price: 2, status: 1)

    @invoice5_item2 = InvoiceItem.create!(item: @item2, invoice: @invoice5, quantity: 2, unit_price: 2, status: 1)
  end

  describe "when i visit the merchant invoice index page" do
    it "shows all of the invoices that includes items from the mrechant" do
      visit "/merchants/#{@merchant1.id}/invoices"

      expect(page).to have_content("Invoices")

      within(".invoices") do
        within("#invoice_id_#{@invoice1.id}") do
          expect(page).to have_link("Invoice #{@invoice1.id}")
          # expect(page).to have_content("Status: #{@invoice1.status}")
        end

        within("#invoice_id_#{@invoice2.id}") do
          expect(page).to have_link("Invoice #{@invoice2.id}")
          # expect(page).to have_content("Status: #{@invoice2.status}")
        end

        within("#invoice_id_#{@invoice3.id}") do
          expect(page).to have_link("Invoice #{@invoice3.id}")
          # expect(page).to have_content("Status: #{@invoice3.status}")
        end

        within("#invoice_id_#{@invoice5.id}") do
          expect(page).to have_link("Invoice #{@invoice5.id}")
          # expect(page).to have_content("Status: #{@invoice5.status}")
        end
      end
    end

    it "does not show invoices that are not associated with the merchant" do
      visit "/merchants/#{@merchant1.id}/invoices"

      expect(page).to_not have_link("Invoice #{@invoice4.id}")
      # expect(page).to have_content("Status: #{@invoice4.status}")
    end
  end
end
