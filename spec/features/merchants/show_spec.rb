require 'rails_helper'

RSpec.describe 'merchant show page' do
  describe 'as a merchant when I visit my dashboard' do
    before(:each) do
      @merch_1 = create(:merchant)
      @merch_2 = create(:merchant)
    end
    it 'displays the name of merchant' do
      visit "/merchants/#{@merch_1.id}/dashboard"
      expect(page).to have_content(@merch_1.name)
      expect(page).to have_no_content(@merch_2.name)
    end

    it 'displays a link to merchant items index' do
      visit "/merchants/#{@merch_1.id}/dashboard"
      within("#my-items") do
       expect(page).to have_link('My Items')

       click_link('My Items')
      end
       expect(current_path).to eq("/merchants/#{@merch_1.id}/items")
    end

    it 'displays a link to merchant invoices index' do
      visit "/merchants/#{@merch_1.id}/dashboard"
      within("#my-invoices") do
       expect(page).to have_link('My Invoices')

       click_link('My Invoices')
      end
       expect(current_path).to eq("/merchants/#{@merch_1.id}/invoices")
    end
  end
    
  describe 'as merchant when I visit the favorite_customer section of the dashboard' do
    before(:each) do
      us_3_test_data
    end
    it 'displays the names of top five customers based on successful transactions' do
      visit "/merchants/#{@merch_1.id}/dashboard"

      expect(page).to have_content(@cust_6.first_name)
      expect(page).to have_content(@cust_6.last_name)
      expect(page).to have_content(@cust_2.first_name)
      expect(page).to have_content(@cust_2.last_name)
      expect(page).to have_content(@cust_3.first_name)
      expect(page).to have_content(@cust_3.last_name)
      expect(page).to have_content(@cust_4.first_name)
      expect(page).to have_content(@cust_4.last_name)
      expect(page).to have_content(@cust_5.first_name)
      expect(page).to have_content(@cust_5.last_name)
      expect(page).to have_no_content(@cust_1.first_name)
      expect(page).to have_no_content(@cust_1.last_name)

      expect(@cust_6.last_name).to appear_before(@cust_2.last_name)
      expect(@cust_2.last_name).to appear_before(@cust_3.last_name)
      expect(@cust_3.last_name).to appear_before(@cust_4.last_name)
      expect(@cust_4.last_name).to appear_before(@cust_5.last_name)
    end

    it 'displays the number of successful transactions next to the customer name' do
      visit "/merchants/#{@merch_1.id}/dashboard"

      within("#customer-#{@cust_6.id}") do
        expect(page).to have_content("6")
      end

      within("#customer-#{@cust_2.id}") do
        expect(page).to have_content("5")
      end
    end

    it 'does not count failed transactions' do
      visit "/merchants/#{@merch_1.id}/dashboard"
      within("#customer-#{@cust_5.id}") do
        expect(page).to have_content("2")
      end
    end
  end
end
