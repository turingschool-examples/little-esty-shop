require 'rails_helper'

RSpec.describe 'Merchant Invoices Index page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')

    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 100, merchant_id: @merchant1.id)

    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id)

    InvoiceItem.create(quantity: 5, unit_price: 500, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    InvoiceItem.create(quantity: 15, unit_price: 1500, status: 'packaged', item_id: @item2.id, invoice_id: @invoice1.id)
  end

  describe 'As a merchant' do
    describe "When I visit my merchant's invoices index (/merchants/merchant_id/invoices)" do
      it "Then I see all of the invoices that include at least one of my merchant's items" do
        visit "/merchants/#{@merchant1.id}/invoices"

        expect(page).to have_content('Invoices:')
        expect(@merchant1.invoices.count).to eq(1)
      end

      it ' And for each invoice I see its id' do
        visit "/merchants/#{@merchant1.id}/invoices"

        within('#invoice_ids') do
          expect(page).to have_content("Invoice: #{@invoice1.id}")
        end
      end

      it 'And each id links to the merchant invoice show page' do
        visit "/merchants/#{@merchant1.id}/invoices"

        within('#invoice_ids') do
          expect(page).to have_link("#{@invoice1.id}")

          click_link("#{@invoice1.id}")

          expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
        end
      end
    end
  end
end
