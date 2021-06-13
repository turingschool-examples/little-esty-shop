require 'rails_helper'
# require 'webmock/rspec'

RSpec.describe 'bulk discounts index page' do
  before(:each) do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @antimerchant = Merchant.create!(name: 'TheOtherOne')

    @discount1 = BulkDiscount.create!(percentage: 10, quantity_threshold: 1, merchant_id: @merchant.id)
    @discount2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 2, merchant_id: @merchant.id)
    @discount3 = BulkDiscount.create!(percentage: 30, quantity_threshold: 3, merchant_id: @merchant.id)

    @discount4 = BulkDiscount.create!(percentage: 40, quantity_threshold: 4, merchant_id: @antimerchant.id)
    @discount5 = BulkDiscount.create!(percentage: 50, quantity_threshold: 5, merchant_id: @antimerchant.id)
    @discount6 = BulkDiscount.create!(percentage: 60, quantity_threshold: 6, merchant_id: @antimerchant.id)

    @customer1 = Customer.create!(first_name: 'John', last_name: 'Smith')
    @customer2 = Customer.create!(first_name: 'Julie', last_name: 'Baker')
    @customer3 = Customer.create!(first_name: 'Jared', last_name: 'Lanata')
    @customer4 = Customer.create!(first_name: 'Jira', last_name: 'Mutiu')
    @customer5 = Customer.create!(first_name: 'Josephina', last_name: 'Cortez')
    @customer6 = Customer.create!(first_name: 'Jemma', last_name: 'Henry')

    @item1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @item3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @merchant.id)
    @item4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.2, merchant_id: @merchant.id)
    @item5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.3, merchant_id: @merchant.id)
    @item6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.4, merchant_id: @antimerchant.id)

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: "2021-06-05 20:11:38.553871")
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer2.id, created_at: "2021-06-07 20:11:38.553871")
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer3.id, created_at: "2021-06-06 20:11:38.553871")
    @invoice4 = Invoice.create!(status: 1, customer_id: @customer4.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice5 = Invoice.create!(status: 1, customer_id: @customer5.id, created_at: "2021-06-02 20:11:38.553871")
    @invoice6 = Invoice.create!(status: 1, customer_id: @customer6.id, created_at: "2021-06-03 20:11:38.553871")

    @invoice_item1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 2, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 1, invoice_id: @invoice1.id, item_id: @item2.id, created_at: "2021-06-05 20:11:38.553871")
    @invoice_item3 = InvoiceItem.create!(quantity: 4, unit_price: 19.4, status: 2, invoice_id: @invoice2.id, item_id: @item3.id)
    @invoice_item4 = InvoiceItem.create!(quantity: 1, unit_price: 12.2, status: 2, invoice_id: @invoice2.id, item_id: @item4.id)
    @invoice_item5 = InvoiceItem.create!(quantity: 2, unit_price: 10.4, status: 2, invoice_id: @invoice2.id, item_id: @item2.id)
    @invoice_item6 = InvoiceItem.create!(quantity: 7, unit_price: 15.3, status: 1, invoice_id: @invoice3.id, item_id: @item5.id, created_at: "2021-06-06 20:11:38.553871")
    @invoice_item7 = InvoiceItem.create!(quantity: 6, unit_price: 10.4, status: 2, invoice_id: @invoice3.id, item_id: @item3.id)
    @invoice_item8 = InvoiceItem.create!(quantity: 3, unit_price: 19.4, status: 1, invoice_id: @invoice4.id, item_id: @item3.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item9 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice5.id, item_id: @item5.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item10 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 2, invoice_id: @invoice6.id, item_id: @item6.id)
    @invoice_item11 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice4.id, item_id: @item1.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item12 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 2, invoice_id: @invoice4.id, item_id: @item2.id)

    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)
    @transaction3 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)

    @transaction4 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction5 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction6 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction7 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735607)

    @transaction8 = @invoice3.transactions.create!(result: 1, credit_card_number: 4203696133194408)

    @transaction9 = @invoice4.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction10 = @invoice4.transactions.create!(result: 1, credit_card_number: 4540842003561938)

    @transaction11 = @invoice5.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction12 = @invoice5.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction13 = @invoice5.transactions.create!(result: 1, credit_card_number: 4203696133194408)

    @transaction14 = @invoice6.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction15 = @invoice6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
    @transaction16 = @invoice6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
    @transaction17 = @invoice6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
    # visit "/merchants/#{@merchant___.id}/bulk_discounts"
    # visit merchant_bulk_discounts_path(@merchant___.id)
  end

  describe 'by merchant' do
    it 'can show all discounts for this merchant' do
      visit merchant_bulk_discounts_path(@merchant.id)

      expect(page).to have_content(@merchant.name)
      expect(page).to_not have_content(@antimerchant.name)

      within("#discounts-#{@discount1.id}") do
        expect(page).to have_link("#{@discount1.percentage}", href: "/merchants/#{@merchant.id}/bulk_discounts/#{@discount1.id}")
        expect(page).to_not have_link("#{@discount1.percentage}", href: "/merchants/#{@merchant.id}/bulk_discounts/#{@discount4.id}")
      end

      within("#discounts-#{@discount2.id}") do
        expect(page).to have_link("#{@discount2.percentage}", href: "/merchants/#{@merchant.id}/bulk_discounts/#{@discount2.id}")
        expect(page).to_not have_link("#{@discount4.percentage}", href: "/merchants/#{@merchant.id}/bulk_discounts/#{@discount4.id}")
      end

      within("#discounts-#{@discount3.id}") do
        expect(page).to have_link("#{@discount3.percentage}", href: "/merchants/#{@merchant.id}/bulk_discounts/#{@discount3.id}")
        expect(page).to_not have_link("#{@discount1.percentage}", href: "/merchants/#{@merchant.id}/bulk_discounts/#{@discount2.id}")
      end
    end
  end

  describe 'holidays' do
    it 'has a section with the header Upcoming Holidays' do
      visit merchant_bulk_discounts_path(@merchant.id)

      expect(page).to have_content("Upcoming Holidays")
    end

    xit 'can request name and date of upcoming holidays from Nager.Date API' do
      visit merchant_bulk_discounts_path(@merchant.id)

      response = Faraday.get 'https://date.nager.at/api/v2/NextPublicHolidays/us'
      parsed = JSON.parse(response.body, symbolize_names: true)
      @holidays = parsed
      mock_response = {
        :date=>"2021-07-05",
        :localName=>"Independence Day",
        :name=>"Independence Day",
        :countryCode=>"US",
        :fixed=>false,
        :global=>true,
        :counties=>"null",
        :launchYear=>"null",
        :type=>"Public"
      }

      allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)
      expect(@holidays[:name]).to eq("Independence Day")
    end
  end

  describe 'create new discount' do
    it 'has a link to create a new discount' do
      visit merchant_bulk_discounts_path(@merchant.id)

      expect(page).to have_link("Create New Discount", href: "/merchants/#{@merchant.id}/bulk_discounts/new")
    end
  end

  describe 'delete discount' do
    it 'has a link to delete a discount' do
      visit merchant_bulk_discounts_path(@merchant.id)

      within("#discounts-#{@discount1.id}") do
        expect(page).to have_link("Delete Discount", href: "/merchants/#{@merchant.id}/bulk_discounts/#{@discount1.id}")
        click_link("Delete Discount")
      end
        expect(page).to_not have_link("#{@discount1.percentage}")

      within("#discounts-#{@discount3.id}") do
        expect(page).to have_link("Delete Discount", href: "/merchants/#{@merchant.id}/bulk_discounts/#{@discount3.id}")
        click_link("Delete Discount")
      end
        expect(page).to_not have_link("#{@discount3.percentage}")
    end
  end
end
