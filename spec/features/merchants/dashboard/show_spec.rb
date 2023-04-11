require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page' do
 before(:each) do
  @merchant_1 = FactoryBot.create(:merchant)
  @merchant_2 = FactoryBot.create(:merchant)
  @merchant_3 = FactoryBot.create(:merchant)
  @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'Description 1', unit_price: 1)
  @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Description 2', unit_price: 2)
  @item_3 = @merchant_2.items.create!(name: 'Item 3', description: 'Description 3', unit_price: 3)
  @item_4 = @merchant_2.items.create!(name: 'Item 4', description: 'Description 4', unit_price: 4)
  @item_5 = @merchant_3.items.create!(name: 'Item 5', description: 'Description 5', unit_price: 5)
  @customer = Customer.create!(first_name: 'Customer', last_name: 'One')
  @invoice_1 = @customer.invoices.create!(status: 0)
  @invoice_2 = @customer.invoices.create!(status: 1)
 end

  describe 'As a merchant' do
    it 'I can see my merchant dashboard' do
      visit dashboard_merchant_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)

      visit dashboard_merchant_path(@merchant_2)

      expect(page).to have_content(@merchant_2.name)
    end
  end

  describe 'As a merchant' do
    it 'I see a link to my merchant items index' do
      visit dashboard_merchant_path(@merchant_1)
      
      within '#links' do
        expect(page).to have_link('My Items')
      end

      visit dashboard_merchant_path(@merchant_2)

      within '#links' do
        expect(page).to have_link('My Items')
      end
    end

    it 'I see a link to my merchant invoices index' do
      visit dashboard_merchant_path(@merchant_1)
      
      within '#links' do
        expect(page).to have_link('My Invoices')
      end

      visit dashboard_merchant_path(@merchant_2)

      within '#links' do
        expect(page).to have_link('My Invoices')
      end
    end
  end
end