require 'rails_helper'

RSpec.describe 'merchant dashboard show page', type: :feature do
  describe 'As a merchant' do
    describe 'When I visit the merchant dashboard /merchants/merchant_id/dashboard' do
      let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}
      let!(:bmv) { Merchant.create!(name: "Bavarian Motor Velocycles")}
    
      let!(:licorice) { carly.items.create!(name: "Licorice Funnels", description: "Some stuff", unit_price: 1200) }
      let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Some stuff", unit_price: 1500) }
      let!(:choco_waffle) { carly.items.create!(name: "Chocolate Waffles Florentine", description: "Some stuff", unit_price: 900) }
      let!(:hummus) { carly.items.create!(name: "Hummus Snocones", description: "Some stuff", unit_price: 1200) }
    
      let!(:skooter) { bmv.items.create!(name: "Hollenskooter", description: "Some stuff", unit_price: 12000) }
      let!(:rider) { bmv.items.create!(name: "Hosenpfloofer", description: "Some stuff", unit_price: 220000) }

      it 'Then I see the name of my merchant' do

        visit "/merchants/#{carly.id}/dashboard"

        expect(page).to have_content("Carly Simon's Candy Silo")
        expect(page).to_not have_content("Bavarian Motor Velocycles")
      end

      it 'Then I see link to my merchant items index (/merchants/merchant_id/items)' do

        visit "/merchants/#{carly.id}/dashboard"

        expect(page).to have_content("#{carly.name}'s Items")
        click_on("#{carly.name}'s Items")
        expect(current_path).to eq(merchant_items_path("#{carly.id}"))
      end

      it 'And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)' do

        visit "/merchants/#{carly.id}/dashboard"

        expect(page).to have_content("#{carly.name}'s Invoices")
        click_on("#{carly.name}'s Invoices")
        expect(current_path).to eq(merchant_invoices_path("#{carly.id}"))
      end

      it 'Then I see the names of the top 5 customers who have conducted the largest number of successful transactions with my merchant' do

      end

      it 'And next to each customer name I see the number of successful transactions they have
      conducted with my merchant' do
      
      end

    end
  end
end

