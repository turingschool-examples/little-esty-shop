require 'rails_helper'

RSpec.describe "Merchant Invoice Index" do 
  before(:each) do 
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @cust1 = create(:customer)
    @cust2 = create(:customer)
    @cust3 = create(:customer)
    @cust4 = create(:customer)
    @cust5 = create(:customer)
    @cust6 = create(:customer)
    @cust7 = create(:customer)
    @cust8 = create(:customer)

    @invoice1 = create(:invoice, customer: @cust1)
    @invoice2 = create(:invoice, customer: @cust2)
    @invoice3 = create(:invoice, customer: @cust3)
    @invoice4 = create(:invoice, customer: @cust4)
    @invoice5 = create(:invoice, customer: @cust5)
    @invoice6 = create(:invoice, customer: @cust6)
    @invoice7 = create(:invoice, customer: @cust7)
    @invoice8 = create(:invoice, customer: @cust8)

    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant2)
    
    
    @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1)
    @invoice_item2 = create(:invoice_item, invoice: @invoice2, item: @item1)
    @invoice_item3 = create(:invoice_item, invoice: @invoice3, item: @item1)
    @invoice_item4 = create(:invoice_item, invoice: @invoice4, item: @item1)
    @invoice_item5 = create(:invoice_item, invoice: @invoice5, item: @item2)
    @invoice_item6 = create(:invoice_item, invoice: @invoice6, item: @item2)
    @invoice_item7 = create(:invoice_item, invoice: @invoice7, item: @item2)
    @invoice_item8 = create(:invoice_item, invoice: @invoice8, item: @item2)
  end
  describe "when I viist a merchants invoices index page" do 
    it "shows all of the invoices that include at least one item from that merchant" do 
      visit "/merchants/#{@merchant1.id}/invoices"

      expect(page).to have_content("#{@merchant1.name}'s Invoices")

      within "#invoice-#{@invoice1.id}" do
        expect(page).to have_content("Invoice # #{@invoice1.id}")
      end

      within "#invoice-#{@invoice2.id}" do
        expect(page).to have_content("Invoice # #{@invoice2.id}")
      end
        
      within "#invoice-#{@invoice3.id}" do
        expect(page).to have_content("Invoice # #{@invoice3.id}")
      end
        
      within "#invoice-#{@invoice4.id}" do
        expect(page).to have_content("Invoice # #{@invoice4.id}")
        click_link("#{@invoice4.id}")
        expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice4.id}")
      end
        
    end
  end
end