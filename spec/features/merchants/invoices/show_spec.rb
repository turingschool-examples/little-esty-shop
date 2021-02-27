require 'rails_helper' 

RSpec.describe "Merchant Invoice Show Page" do 
  before(:each) do 
    @merchant1 = create(:merchant)
    @cust1 = create(:customer)
    @invoice1 = create(:invoice, customer: @cust1)
    @item1 = create(:item, merchant: @merchant1)
    @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1)
  end

  describe "When I visit the merchant invoice show page do" do 
    it "it displays the invoice id, invoice status, invoice created at date formatted properly" do 
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content("#{@merchant1.name} - Invoice # #{@invoice1.id}")

      within "#invoice-info" do 
        expect(page).to have_content("Status: #{@invoice1.status}")
        expect(page).to have_content("Created At: #{@invoice1.created_at.strftime('%A, %B %d, %Y')}")
      end

      within "#customer-info" do 
        expect(page).to have_content("First name: #{@cust1.first_name}")
        expect(page).to have_content("Last name: #{@cust1.last_name}")
      end

    end
  end
end