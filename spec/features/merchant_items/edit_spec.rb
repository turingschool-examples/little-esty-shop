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
    it 'is filled in with existing attribute information and displays success message' do
      visit "/merchants/#{merchants[0].id}/items/#{@items[0].id}"

      expect(page).to_not have_content('Bow Tie Pasta')
      expect(page).to_not have_content('Tasty')

      visit "/merchants/#{merchants[0].id}/items/#{@items[0].id}/edit"

      fill_in('item[name]', with: 'Bow Tie Pasta')
      fill_in('item[description]', with: 'Tasty')
      click_on('Submit')
      expect(current_path).to eq("/merchants/#{merchants[0].id}/items/#{@items[0].id}")
      expect(page).to have_content('Item Successfully Updated')
      expect(page).to have_content('Bow Tie Pasta')
      expect(page).to have_content('Tasty')
    end

    it "returns an error if required information is missing" do
      visit "/merchants/#{merchants[0].id}/items/#{@items[0].id}/edit"

      fill_in('item[name]', with: '')
      fill_in('item[description]', with: 'Tasty')
      click_on('Submit')
      
      expect(current_path).to eq("/merchants/#{merchants[0].id}/items/#{@items[0].id}")
      expect(page).to have_content('A Required Field Was Missing; Item Not Updated')
      expect(page).to_not have_content('Tasty')
    end
  end
end
