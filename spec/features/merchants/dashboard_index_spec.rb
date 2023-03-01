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
    let!(:customer6) { create(:customer) }
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
    let!(:invoice11) { create(:invoice, customer_id: customer6.id) }
    let!(:item1) { create(:item, merchant_id: merchant1.id)}
    let!(:item2) { create(:item, merchant_id: merchant1.id)}
    let!(:item3) { create(:item, merchant_id: merchant1.id)}
    let!(:item4) { create(:item, merchant_id: merchant1.id)}
    let!(:item5) { create(:item, merchant_id: merchant1.id)}
    let!(:item6) { create(:item, merchant_id: merchant1.id)}
    let!(:item7) { create(:item, merchant_id: merchant1.id)}
    let!(:item8) { create(:item, merchant_id: merchant1.id)}
    let!(:item9) { create(:item, merchant_id: merchant1.id)}
    let!(:item10) { create(:item, merchant_id: merchant1.id)}
    let!(:item11) { create(:item, merchant_id: merchant1.id)}
    let!(:transaction1) { create(:transaction, invoice_id: invoice1.id, result: "success")}
    let!(:transaction2) { create(:transaction, invoice_id: invoice2.id, result: "success")}
    let!(:transaction3) { create(:transaction, invoice_id: invoice3.id, result: "success")}
    let!(:transaction4) { create(:transaction, invoice_id: invoice4.id, result: "success")}
    let!(:transaction5) { create(:transaction, invoice_id: invoice4.id, result: "success")}
    let!(:transaction6) { create(:transaction, invoice_id: invoice5.id, result: "success")}
    let!(:transaction7) { create(:transaction, invoice_id: invoice6.id, result: "success")}
    let!(:transaction8) { create(:transaction, invoice_id: invoice7.id, result: "success")}
    let!(:transaction9) { create(:transaction, invoice_id: invoice7.id, result: "success")}
    let!(:transaction10) { create(:transaction, invoice_id: invoice8.id, result: "success")}
    let!(:transaction11) { create(:transaction, invoice_id: invoice8.id, result: "success")}
    let!(:transaction12) { create(:transaction, invoice_id: invoice9.id, result: "success")}
    let!(:transaction13) { create(:transaction, invoice_id: invoice10.id, result: "success")}
    let!(:transaction14) { create(:transaction, invoice_id: invoice10.id, result: "success")}
    let!(:transaction15) { create(:transaction, invoice_id: invoice11.id, result: "failed")}
    let!(:transaction16) { create(:transaction, invoice_id: invoice11.id, result: "failed")}
    let!(:transaction17) { create(:transaction, invoice_id: invoice7.id, result: "failed")}
    let!(:transaction18) { create(:transaction, invoice_id: invoice2.id, result: "failed")}

    before do
      InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, status: "packaged") 
      InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, status: "pending") 
      InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, status: "shipped") 
      InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, status: "packaged") 
      InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, status: "pending") 
      InvoiceItem.create!(item_id: item6.id, invoice_id: invoice6.id, status: "pending") 
      InvoiceItem.create!(item_id: item7.id, invoice_id: invoice7.id, status: "shipped") 
      InvoiceItem.create!(item_id: item8.id, invoice_id: invoice8.id, status: "shipped") 
      InvoiceItem.create!(item_id: item9.id, invoice_id: invoice9.id, status: "packaged") 
      InvoiceItem.create!(item_id: item10.id, invoice_id: invoice10.id, status: "packaged") 
      InvoiceItem.create!(item_id: item11.id, invoice_id: invoice11.id, status: "shipped")

      visit "/merchants/#{merchant1.id}/dashboard"
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
        expect(page).to have_content("#{customer2.first_name} #{customer2.last_name}: #{customer2.transaction_count} successful transactions")
        expect(page).to have_content("#{customer3.first_name} #{customer3.last_name}: #{customer3.transaction_count} successful transactions")
        expect(page).to have_content("#{customer1.first_name} #{customer1.last_name}: #{customer1.transaction_count} successful transactions")
        expect(page).to have_content("#{customer5.first_name} #{customer5.last_name}: #{customer5.transaction_count} successful transactions")
        expect(page).to have_content("#{customer4.first_name} #{customer4.last_name}: #{customer4.transaction_count} successful transactions")
        expect(page).to_not have_content("#{customer6.first_name} #{customer6.last_name}: #{customer6.transaction_count} successful transactions")
      end
      
      # 4. Merchant Dashboard Items Ready to Ship

      it "I see a section for Items Ready to Ship & names of items that have not been shipped" do
        expect(page).to have_content("Items Ready to Ship")
        expect(page).to have_content(("#{item1.name}: #{item1.item_invoice_id}"))
        expect(page).to have_link("#{item1.item_invoice_id}")
        # to merchant's invoice show page

        expect(page).to_not have_content(("#{item3.name}: #{item3.item_invoice_id}"))
        expect(page).to_not have_link("#{item3.item_invoice_id}")


      end
    end

    describe "things that" do
      # 5. Merchant Dashboard Invoices sorted by least recent

      # Next to each Item name I see the date that the invoice was created
      # And I see the date formatted like "Monday, July 18, 2019"
      # And I see that the list is ordered from oldest to newest

      it "In Items Ready to Ship, I see the date the invoice was created, oldest to newest" do 

        merchant21 = create(:merchant) 
        customer21 = create(:customer) 
        customer22 = create(:customer)
        customer24 = create(:customer)
        customer25 = create(:customer)
        invoice21 = create(:invoice, customer_id: customer21.id) 
        invoice24 = create(:invoice, customer_id: customer22.id)
        invoice29 = create(:invoice, customer_id: customer24.id)
        invoice20 = create(:invoice, customer_id: customer25.id)
        item21 = create(:item, merchant_id: merchant21.id)
        item24 = create(:item, merchant_id: merchant21.id)
        item29 = create(:item, merchant_id: merchant21.id)
        item20 = create(:item, merchant_id: merchant21.id)
  
        InvoiceItem.create!(item_id: item21.id, invoice_id: invoice21.id, status: "packaged")
        InvoiceItem.create!(item_id: item24.id, invoice_id: invoice24.id, status: "packaged")
        InvoiceItem.create!(item_id: item29.id, invoice_id: invoice29.id, status: "packaged")
        InvoiceItem.create!(item_id: item20.id, invoice_id: invoice20.id, status: "packaged")
        # require 'pry'; binding.pry
      
        expect(page).to have_content("Wednesday, March 1, 2023")
      end
    end
  end
end