require "rails_helper"

RSpec.describe "Merchant Invoices Show" do
  before :each do
    @merchants = create_list(:merchant, 3)
    @items1 = create_list(:item, 3, merchant: @merchants[0])
    @items2 = create_list(:item, 2, merchant: @merchants[1])
    @customers = create_list(:customer, 2)

    @invoices1 = create_list(:invoice, 2, customer: @customers[0])
    @invoice_item1 = create(:invoice_item, invoice: @invoices1[0], item: @items1[0])
    @invoice_item3 = create(:invoice_item, invoice: @invoices1[1], item: @items1[1])
    @invoice_item2 = create(:invoice_item, invoice: @invoices1[0], item: @items1[2])

    @invoices2 = create_list(:invoice, 2, customer: @customers[1])
    @invoice_item6 = create(:invoice_item, invoice: @invoices2[0], item: @items2[0])
    @invoice_item4 = create(:invoice_item, invoice: @invoices2[1], item: @items2[1])

    visit merchant_invoice_path(@merchants[0], @invoices1[0])
  end

  describe "display" do
    it "invoice attributes", :vcr do
      expect(page).to have_content(@invoices1[0].id)
      expect(page).to have_content("Status: In Progress")
      expect(page).to have_content("Created On: #{@invoices1[0].created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content(@invoices1[0].customer.full_name)
      expect(page).to_not have_content(@invoices1[1])
      expect(page).to_not have_content(@invoices2)
    end

    describe "invoice items" do
      it "lists all invoice item names, quantity, price and status", :vcr do
        within "#invoice_item-#{@invoice_item2.id}" do
          expect(page).to have_content(@invoice_item2.item.name)
          expect(page).to have_content(@invoice_item2.quantity)
          expect(page).to have_content(@invoice_item2.unit_price)
          expect(page).to have_content(@invoice_item2.status)
          expect(page).to_not have_content(@items1[1])
          expect(page).to_not have_content(@items2)
        end

        visit merchant_invoice_path(@merchants[1], @invoices2[0])
        within "#invoice_item-#{@invoice_item6.id}" do
          expect(page).to have_content(@invoice_item6.item.name)
          expect(page).to have_content(@invoice_item6.quantity)
          expect(page).to have_content(@invoice_item6.unit_price)
          expect(page).to have_content(@invoice_item6.status)
          expect(page).to_not have_content(@items2[1])
          expect(page).to_not have_content(@items1)
        end
      end

      it 'select update invoice item status', :vcr do
        visit merchant_invoice_path(@merchants[0], @invoices1[0])
        within "#invoice_item-#{@invoice_item2.id}" do
          expect(page).to have_content('Pending')
          select 'Packaged'
          click_button 'Update Invoice Item Status'

          expect(current_path).to eq(merchant_invoice_path(@merchants[0], @invoices1[0]))
          expect(@invoice_item2.reload.status).to eq("Packaged")
        end
      end
    end
  end
end
