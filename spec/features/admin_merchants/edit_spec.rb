require 'rails_helper'

RSpec.describe 'Admin Merchants Edit Page', type: :feature do
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

  describe 'admin merchant update' do
    it 'has a form to update the merchant name' do
      visit "/admin/merchants/#{merchants[0].id}"
      expect(page).to_not have_content('Crunch Wrap Industries')

      visit "/admin/merchants/#{merchants[0].id}/edit"

      fill_in 'Name', with: 'Crunch Wrap Industries'
      click_on 'Submit'
      expect(current_path).to eq("/admin/merchants/#{merchants[0].id}")
      expect(page).to have_content('Crunch Wrap Industries')
      expect(page).to have_content('Merchant Successfully Updated')
    end

    it 'returns an error if required info is missing' do
      visit "/admin/merchants/#{merchants[0].id}/edit"

      fill_in 'Name', with: ''
      click_on 'Submit'
      expect(current_path).to eq("/admin/merchants/#{merchants[0].id}")
      expect(page).to have_content('A Required Field Was Missing; Merchant Not Updated')
    end
  end
end
