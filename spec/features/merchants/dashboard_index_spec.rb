require 'rails_helper'

RSpec.describe "Merchant Dashboard Index" do
  describe "As a merchant" do
    let!(:merchant1) { create(:merchant) }
    let!(:merchant2) { create(:merchant) }
    let!(:customer1) { create(:customer) }
    let!(:customer2) { create(:customer) }
    let!(:customer3) { create(:customer) }
    let!(:customer4) { create(:customer) }
    let!(:customer5) { create(:customer) }
    let!(:invoice1) { create(:invoice, customer_id: customer1.id) }
    let!(:invoice2) { create(:invoice, customer_id: customer1.id) }
    let!(:invoice3) { create(:invoice, customer_id: customer1.id) }
    let!(:invoice4) { create(:invoice, customer_id: customer2.id) }
    let!(:invoice5) { create(:invoice, customer_id: customer2.id) }
    let!(:invoice6) { create(:invoice, customer_id: customer2.id) }
    let!(:invoice7) { create(:invoice, customer_id: customer3.id) }
    let!(:invoice8) { create(:invoice, customer_id: customer3.id) }
    let!(:invoice9) { create(:invoice, customer_id: customer4.id) }
    let!(:invoice10) { create(:invoice, customer_id: customer5.id) }
    let!(:transaction1) { create(:transaction, invoice_id: invoice1.id)}
    let!(:transaction2) { create(:transaction, invoice_id: invoice2.id)}
    let!(:transaction3) { create(:transaction, invoice_id: invoice3.id)}
    let!(:transaction4) { create(:transaction, invoice_id: invoice4.id)}
    let!(:transaction5) { create(:transaction, invoice_id: invoice4.id)}
    let!(:transaction6) { create(:transaction, invoice_id: invoice5.id)}
    let!(:transaction7) { create(:transaction, invoice_id: invoice6.id)}
    let!(:transaction8) { create(:transaction, invoice_id: invoice7.id)}
    let!(:transaction9) { create(:transaction, invoice_id: invoice7.id)}
    let!(:transaction10) { create(:transaction, invoice_id: invoice8.id)}
    let!(:transaction11) { create(:transaction, invoice_id: invoice8.id)}
    let!(:transaction12) { create(:transaction, invoice_id: invoice8.id)}
    let!(:transaction13) { create(:transaction, invoice_id: invoice8.id)}
    let!(:transaction14) { create(:transaction, invoice_id: invoice8.id)}

  
    before do
      
      visit "/merchants/#{merchant1.id}/dashboards"
    end
  
    # 1. Merchant Dashboard
    context "When I visit /merchants/merchant_id/dashboard" do
      it "Then I see the name of my merchant" do
        expect(page).to have_content("Name: #{merchant1.name}")
        expect(page).to_not have_content(merchant2.name)
      end
      
      # 2. Merchant Dashboard Links
      it "Then I see link to my merchant items index (/merchants/merchant_id/items)" do 
        expect(page).to have_link("Items")
      end
      
      it "Then I see a link to my merchant invoices index (/merchants/merchant_id/invoices)" do 
        expect(page).to have_link("Invoices")
      end

      # 3. Merchant Dashboard Statistics - Favorite Customers
      it "I see the names of the top 5 customers w/ the largest number of transactions" do
        expect(page).to have_content("#{customer1.name}: transactions")
      end
    end
  end
end