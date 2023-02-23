require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before do
    Merchant.destroy_all
		Customer.destroy_all
		Invoice.destroy_all
		Item.destroy_all
		Transaction.destroy_all
		InvoiceItem.destroy_all

		@carlos = Merchant.create!(name: "Carlos Jenkins")
		@pete = Merchant.create!(name: "Pete Smith") 

    @bowl = @carlos.items.create!(name: "Bowl", description: "it's a bowl", unit_price: 350) 
		@knife = @carlos.items.create!(name: "Knife", description: "it's a knife", unit_price: 250)

    @scarf = @pete.items.create!(name: "Scarf", description: "scarf, knitted", unit_price: 350) 
		@tshirt = @pete.items.create!(name: "Tshirt", description: "tshirt, screenprinted", unit_price: 250)

    visit "/merchants/#{@carlos.id}/items}"
  end

  describe 'As a merchant, when I visit my merchant items index page' do
    it 'I see a list of the names of all of my items, no items from other merchants' do
      expect(page).to have_content("bowl")
      expect(page).to have_content("knife")

      expect(page).to_not have_content("scarf")
      expect(page).to_not have_content("tshirt")
    end
  end
end