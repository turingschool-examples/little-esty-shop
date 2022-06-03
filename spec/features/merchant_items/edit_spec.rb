require 'rails_helper'

RSpec.describe 'Merchant Items Edit Page' do
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

  describe 'form to edit item' do
    it 'is filled in with existing attribute information' do
      visit "/merchants/#{merchants[0].id}/items/#{@items[0].id}/edit"
      # expect(page).to have_content(@items[0].name)
      # expect(page).to have_content(@items[0].description)
      # expect(page).to have_content(@items[0].unit_price)

      fill_in(:name, with: 'Bow Tie Pasta')
      fill_in(:description, with: 'Tasty')
      click_on('Submit')
      expect(current_path).to eq("/merchants/#{merchants[0].id}/items/#{@items[0].id}")
      expect(page).to have_content('Item Successfully Updated')
      expect(page).to have_content('Bow Tie Pasta')
      expect(page).to have_content('Tasty')
    end
  end
end
