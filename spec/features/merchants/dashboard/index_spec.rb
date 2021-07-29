require 'rails_helper'

RSpec.describe 'Merchants dashboard index page' do
  describe "dashboard" do

    before(:each) do
      @merchant_1 = create(:merchant)
      visit "/merchants/#{@merchant_1.id}/dashboard"
    end

    it 'can display merchant name' do
      expect(page).to have_content(@merchant_1.name)
    end

    it 'displays links to items and invoices index' do
      expect(page).to have_link('My Items')
      expect(page).to have_link('My Invoices')
    end

    describe 'items ready to ship section' do
      before(:each) do

        @customers = []
        @invoices = []
        @items = []
        @transactions = []
        @invoice_items = []

        2.times do
          @customers << create(:customer)
          @invoices << create(:invoice, customer_id: @customers.last.id)
          @items << create(:item, merchant_id: @merchant_1.id)
          @transactions << create(:transaction, invoice_id: @invoices.last.id)
          @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1)
        end
        3.times do
          @customers << create(:customer)
          @invoices << create(:invoice, customer_id: @customers.last.id)
          @items << create(:item, merchant_id: @merchant_1.id)
          @transactions << create(:transaction, invoice_id: @invoices.last.id)
          @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 2)
        end
        visit "/merchants/#{@merchant_1.id}/dashboard"
      end

      it 'see a list of all items that have been ordered and not yet shipped' do
        expect(page).to have_content("Items Ready to Ship")

        expect(page).to have_content(@items[1].name)
        expect(page).to have_content(@invoices[1].id)

        expect(page).to have_content(@items[0].name)
        expect(page).to have_content(@invoices[0].id)

        expect(page).to_not have_content(@items[3].name)
        expect(page).to_not have_content(@invoices[3].id)
      end

      it "invoice id has link to this merchants show page" do
        click_link "#{@invoices[1].id}"

        expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoices[1].id}")
      end

      it "has date formated correctly" do
        @customers << create(:customer)
        @invoices << create(:invoice, customer_id: @customers.last.id, created_at: DateTime.new(2020,2,3,4,5,6))
        @items << create(:item, merchant_id: @merchant_1.id)
        @transactions << create(:transaction, invoice_id: @invoices.last.id)
        @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1)

        visit "/merchants/#{@merchant_1.id}/dashboard"

        expect(page).to have_content("Monday February 3, 2020")
      end

      it "has items in order from oldest to newest" do
        @customers << create(:customer)
        @invoices << create(:invoice, customer_id: @customers.last.id, created_at: DateTime.new(2020,2,3,4,5,6))
        @items << create(:item, merchant_id: @merchant_1.id)
        @transactions << create(:transaction, invoice_id: @invoices.last.id)
        @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1)

        visit "/merchants/#{@merchant_1.id}/dashboard"

        expect(@items[5].name).to appear_before(@items[0].name) # 5 is manually set to be oldest
        expect(@items[0].name).to appear_before(@items[1].name)
      end
    end
  end
end
