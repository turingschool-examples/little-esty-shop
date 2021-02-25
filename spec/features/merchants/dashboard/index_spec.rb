require 'rails_helper'

RSpec.describe "Merchant Dashboard" do 
  before(:each) do 
    @merchant = create(:merchant)

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
    

    create_list(:transaction, 1, result: "success", invoice: @invoice1) 
    create_list(:transaction, 2, result: "success", invoice: @invoice2)
    create_list(:transaction, 6, result: "success", invoice: @invoice3)
    create_list(:transaction, 5, result: "success", invoice: @invoice4)
    create_list(:transaction, 4, result: "success", invoice: @invoice5)
    create_list(:transaction, 8, result: "success", invoice: @invoice6)
    create_list(:transaction, 5, result: "success", invoice: @invoice7)
    create_list(:transaction, 1, result: "success", invoice: @invoice8)

    @item1 = create(:item, merchant: @merchant)
    
    @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1)
    @invoice_item2 = create(:invoice_item, invoice: @invoice2, item: @item1)
    @invoice_item3 = create(:invoice_item, invoice: @invoice3, item: @item1)
    @invoice_item4 = create(:invoice_item, invoice: @invoice4, item: @item1)
    @invoice_item5 = create(:invoice_item, invoice: @invoice5, item: @item1)
    @invoice_item6 = create(:invoice_item, invoice: @invoice6, item: @item1)
    @invoice_item7 = create(:invoice_item, invoice: @invoice7, item: @item1)
    @invoice_item8 = create(:invoice_item, invoice: @invoice8, item: @item1)
  end

  describe "When I vist a merchants dashboard" do 
    it "shows the merchants name and links to items and invoices" do 
      visit "/merchant/#{@merchant.id}/dashboard"
  
      expect(page).to have_content(@merchant.name)

      expect(page).to have_link("My Items")
      expect(page).to have_link("My Invoices")
    end

    it "shows the top 5 customers" do 
      visit "/merchant/#{@merchant.id}/dashboard"

        expect(page).to have_content(@cust3.first_name)
        expect(page).to have_content(@cust4.first_name)
        expect(page).to have_content(@cust5.first_name)
        expect(page).to have_content(@cust6.first_name)
        expect(page).to have_content(@cust7.first_name)

        expect(page).to have_content(6)
        expect(page).to have_content(5)
        expect(page).to have_content(4)
        expect(page).to have_content(8)
        expect(page).to have_content(5)
      
   end

    xit "and I click on the My Items link it takes me to that merchants items page" do 
      visit "/merchant/#{@merchant.id}/dashboard"

      expect(page).to have_content(@merchant.name)

      click_on "My Items"

      expect(current_path).to eq("/merchant/#{@merchant.id}/items")
    end

    xit "and I click on the My Invocies link it takes me to that merchants invoices page" do 
      visit "/merchant/#{@merchant.id}/dashboard"

      expect(page).to have_content(@merchant.name)

      click_on "My Invoices"

      expect(current_path).to eq("/merchant/#{@merchant.id}/invoices")
    end
  end
end