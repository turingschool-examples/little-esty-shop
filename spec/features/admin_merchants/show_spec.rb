require 'rails_helper'

# Admin Merchant Show
#
# As an admin,
# When I click on the name of a merchant from the admin merchants index page,
# Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
# And I see the name of that merchant


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

    it 'has a form to update the merchant name' do 
      visit "/admin/merchants/#{merchants[0].id}/edit"
      # save_and_open_page
    
      fill_in 'Name', with: 'Cruch Wrap Industries'
      click_on 'Submit'
      expect(current_path).to eq("/admin/merchants/#{merchants[0].id}")
      expect(page).to have_content('Crunch Wrap Industries')
    end
  end
end
