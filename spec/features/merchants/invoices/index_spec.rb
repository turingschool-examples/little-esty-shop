require 'rails_helper'

RSpec.describe 'Merchants invoices index page' do
  describe "invoices" do
    before(:each) do
      @merchant_1 = create(:merchant)

      @customers = []
      @invoices = []
      @items = []
      @transactions = []
      @invoice_items = []

      5.times do
        @customers << create(:customer)
        @invoices << create(:invoice, customer_id: @customers.last.id)
        @items << create(:item, merchant_id: @merchant_1.id)
        @transactions << create(:transaction, invoice_id: @invoices.last.id)
        @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1)
      end

      visit "/merchants/#{@merchant_1.id}/invoices"
    end

    it "can be reached" do
      expect(page).to have_content("#{@merchant_1.name}'s Invoices")
    end

    it "lists all invoices for that merchant" do
      expect(page).to have_content(@invoices[0].id)
      expect(page).to have_content(@invoices[1].id)
      expect(page).to have_content(@invoices[2].id)
      expect(page).to have_content(@invoices[3].id)
      expect(page).to have_content(@invoices[4].id)
    end

    it "has id's link to to that invoice show page" do
      click_link "#{@invoices[0].id}"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoices[0].id}")
    end
  end
end
