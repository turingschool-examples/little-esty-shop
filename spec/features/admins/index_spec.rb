require 'rails_helper'

RSpec.describe "The Admin Index" do
  before(:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,1,1))
    @invoice_2 = create(:invoice, customer_id: @customer_2.id, created_at: Date.new(2023,1,1).next)
    @invoice_3 = create(:invoice, customer_id: @customer_3.id, created_at: Date.new(2023,1,1).next.next)
    @invoice_4 = create(:invoice, customer_id: @customer_4.id)
    @invoice_5 = create(:invoice, customer_id: @customer_5.id)

    @merchant_1 = create(:merchant)
    
    contributors_json_response = File.open("./fixtures/contributors.json")
    pulls_json_response = File.open("./fixtures/pulls.json")
    repo_json_response = File.open("./fixtures/repo.json")

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop").
      to_return(status: 200, body: repo_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed").
      to_return(status: 200, body: pulls_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/contributors").
      to_return(status: 200, body: contributors_json_response)
  end
  
  describe "User Story 19" do
    it "When an admin the admin dashboard (/admin), they see a header indicating that they are on the admin dashboard" do 
      visit admin_index_path

      expect(page).to have_content("Admin Dashboard")
    end
  end
  
  describe "User Story 20" do
    it "When I visit the admin dashboard (/admin) then I see a link to the admin merchants index (/admin/merchants)
    and I see a link to the admin invoices index (/admin/invoices)" do
    
      visit admin_index_path

      expect(page).to have_link("Merchants", href: admin_merchants_path)
      expect(page).to have_link("Invoices", href: admin_invoices_path)
    end
  end

  describe "User Story 21" do
    it "When I visit the admin dashboard then I see the names of the top 5 customers by largest number of successful transactions
    with the number of successful transactions they have conducted" do
      create(:transaction, invoice_id: @invoice_1.id, result: 0)
      2.times { create(:transaction, invoice_id: @invoice_2.id, result: 0) }
      3.times { create(:transaction, invoice_id: @invoice_3.id, result: 0) }
      4.times { create(:transaction, invoice_id: @invoice_4.id, result: 0) }
      5.times { create(:transaction, invoice_id: @invoice_5.id, result: 0) }

      visit admin_index_path

      customer_5_full_name = "#{@customer_5.first_name} #{@customer_5.last_name}"
      customer_4_full_name = "#{@customer_4.first_name} #{@customer_4.last_name}"
      customer_3_full_name = "#{@customer_3.first_name} #{@customer_3.last_name}"
      customer_2_full_name = "#{@customer_2.first_name} #{@customer_2.last_name}"
      customer_1_full_name = "#{@customer_1.first_name} #{@customer_1.last_name}"

      within("#top_customers") {
        expect("#{customer_5_full_name} - 5 purchases").to appear_before("#{customer_4_full_name} - 4 purchases")
        expect("#{customer_4_full_name} - 4 purchases").to appear_before("#{customer_3_full_name} - 3 purchases")
        expect("#{customer_3_full_name} - 3 purchases").to appear_before("#{customer_2_full_name} - 2 purchases")
        expect("#{customer_2_full_name} - 2 purchases").to appear_before("#{customer_1_full_name} - 1 purchases")
        expect(page).to_not have_content("#{@customer_6.first_name} #{@customer_6.last_name}")
      }
    end
  end
  context 'Incomplete Invoices' do
    before(:each) do
      item_1 = create(:item, merchant_id: @merchant_1.id)
      item_2 = create(:item, merchant_id: @merchant_1.id)
      item_3 = create(:item, merchant_id: @merchant_1.id)
      item_4 = create(:item, merchant_id: @merchant_1.id)
      item_5 = create(:item, merchant_id: @merchant_1.id) 
      
      @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: item_1.id, status: 0)
      @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: item_2.id, status: 0)
      @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_3.id, item_id: item_3.id, status: 0)
      @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_3.id, item_id: item_4.id, status: 0)
      @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_4.id, item_id: item_5.id, status: 2)

      visit admin_index_path
    end

    describe "User Story 22" do
      it "When I visit the admin dashboard, I see a section for 'Incomplete Invoices', In that section I see a list of the ids of all invoices 
        that have items that have not yet been shipped, and each invoice id links to that invoice's admin show page" do
        within("#incomplete_invoices") {
          within("#incomplete_invoice-#{@invoice_1.id}")  {
            expect(page).to have_content("Invoice ##{@invoice_1.id}")
            expect(page).to have_link("#{@invoice_1.id}", href: admin_invoice_path(@invoice_1))
          }
          within("#incomplete_invoice-#{@invoice_2.id}")  {
            expect(page).to have_content("Invoice ##{@invoice_2.id}")
            expect(page).to have_link("#{@invoice_2.id}", href: admin_invoice_path(@invoice_2))
          }
          within("#incomplete_invoice-#{@invoice_3.id}")  {
            expect(page).to have_content("Invoice ##{@invoice_3.id}")
            expect(page).to have_link("#{@invoice_3.id}", href: admin_invoice_path(@invoice_3))
          }

          expect(page).to_not have_content("Invoice ##{@invoice_4.id}")
        }
      end
    end

    describe "User Story 23" do
      it "Next to each invoice id I see the date that the invoice was created formatted like 'Monday, July 18, 2019', ordered from oldest to newest" do
        within("#incomplete_invoices") {
          expect("Sunday, January 01, 2023").to appear_before("Monday, January 02, 2023")
          expect("Monday, January 02, 2023").to appear_before("Tuesday, January 03, 2023")

          within("#incomplete_invoice-#{@invoice_1.id}")  {
            expect(page).to have_content("Invoice ##{@invoice_1.id} - Sunday, January 01, 2023")
          }
          within("#incomplete_invoice-#{@invoice_2.id}")  {
            expect(page).to have_content("Invoice ##{@invoice_2.id} - Monday, January 02, 2023")
          }
          within("#incomplete_invoice-#{@invoice_3.id}")  {
            expect(page).to have_content("Invoice ##{@invoice_3.id} - Tuesday, January 03, 2023")
          }
        }
      end
    end
  end
end