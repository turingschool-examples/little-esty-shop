require 'rails_helper'

RSpec.describe 'Admin Merchants Show Page', type: :feature do
  let!(:merchants) { create_list(:merchant, 2) }
  let!(:customers) { create_list(:customer, 6) }

  before :each do
    @items = merchants.flat_map do |merchant|
      create_list(:item, 2, merchant: merchant)
    end

    @invoices = customers.flat_map do |customer|
      create_list(:invoice, 2, customer: customer)
    end

    @transactions = @invoices.each_with_index.flat_map do |invoice, index|
      if index < 2
        create_list(:transaction, 2, invoice: invoice, result: 1)
      else
        create_list(:transaction, 2, invoice: invoice, result: 0)
      end
    end
  end

  describe 'User Story 2 - Admin Merchant Show' do
    it "can display the merchants name" do
      visit "/admin/merchants"

      click_link "#{merchants[0].name}"
      expect(current_path).to eq("/admin/merchants/#{merchants[0].id}")
      expect(page).to have_content("#{merchants[0].name}")
    end
  end

  describe 'admin merchant update' do
    it 'has a link to update the merchants information' do 
      visit "/admin/merchants/#{merchants[0].id}"

      click_link "Update Merchant"
      expect(current_path).to eq("/admin/merchants/#{merchants[0].id}/edit")
    end
  end
end
