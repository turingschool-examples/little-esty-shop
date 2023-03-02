require 'rails_helper'

RSpec.describe "Merchant_Invoices#Index", type: :feature do
  before(:each) do
    @merchant = create(:merchant)
    @merchant_2 = create(:merchant)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,1,1))
    @invoice_2 = create(:invoice, customer_id: @customer_2.id, created_at: Date.new(2022,1,1))
    @invoice_3 = create(:invoice, customer_id: @customer_3.id, created_at: Date.new(2021,1,1))
    @invoice_4 = create(:invoice, customer_id: @customer_4.id, created_at: Date.new(2020,1,1))
    @invoice_5 = create(:invoice, customer_id: @customer_5.id, created_at: Date.new(2019,1,1))
    @invoice_6 = create(:invoice, customer_id: @customer_6.id, created_at: Date.new(2018,1,1))
    @invoice_7 = create(:invoice, customer_id: @customer_6.id, created_at: Date.new(2017,1,1))

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @item_4 = create(:item, merchant: @merchant)
    @item_5 = create(:item, merchant: @merchant)
    @item_6 = create(:item, merchant: @merchant)
    @item_7 = create(:item, merchant: @merchant_2)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 1, status: "packaged", created_at: Date.new(2023,1,1))
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 1, status: "packaged", created_at: Date.new(2023,1,2))
    @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 1, status: "packaged", created_at: Date.new(2023,1,3))
    @invoice_item_4 = create(:invoice_item, item: @item_4, invoice: @invoice_4, quantity: 1, status: "packaged", created_at: Date.new(2023,1,4))
    @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_5, quantity: 1, status: "packaged", created_at: Date.new(2023,1,5))
    @invoice_item_6 = create(:invoice_item, item: @item_6, invoice: @invoice_6, quantity: 1, status: "packaged", created_at: Date.new(2023,1,6))
    @invoice_item_7 = create(:invoice_item, item: @item_7, invoice: @invoice_7, quantity: 1, status: "shipped", created_at: Date.new(2023,1,7))

    create(:transaction, invoice_id: @invoice_1.id, result: 0)
    create(:transaction, invoice_id: @invoice_2.id, result: 0)
    create(:transaction, invoice_id: @invoice_3.id, result: 0)
    create(:transaction, invoice_id: @invoice_4.id, result: 0)
    create(:transaction, invoice_id: @invoice_5.id, result: 0)
    create(:transaction, invoice_id: @invoice_6.id, result: 0)
    create(:transaction, invoice_id: @invoice_7.id, result: 0)

    contributors_json_response = File.open("./fixtures/contributors.json")
    pulls_json_response = File.open("./fixtures/pulls.json")
    repo_json_response = File.open("./fixtures/repo.json")

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop").
      to_return(status: 200, body: repo_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed").
      to_return(status: 200, body: pulls_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/contributors").
      to_return(status: 200, body: contributors_json_response)

    
    visit "/merchants/#{@merchant.id}/invoices"
  end

  describe "User Story 14" do
    context "As a merchant, when I visit my merchant's invoices index" do
      it "I see all of the invoices that include at least one of my merchant's items and 
        for each invoice I see its id and each id links to the merchant invoice show page" do
        within("#merchant_invoices") do
          expect(page).to have_content(@invoice_1.id)
          expect(page).to have_content(@invoice_2.id)
          expect(page).to have_content(@invoice_3.id)
          expect(page).to have_content(@invoice_4.id)
          expect(page).to have_content(@invoice_5.id)
          expect(page).to have_content(@invoice_6.id)
          expect(page).to_not have_content(@invoice_7.id)
          
          click_link "#{@invoice_1.id}"

          expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
        end
      end
    end
  end
end