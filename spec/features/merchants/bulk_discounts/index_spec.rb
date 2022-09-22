require 'rails_helper'

RSpec.describe 'bulk discount index page', type: :feature do
  describe 'As a visitor' do
    describe 'When I visit the bulk discount index page' do
      let!(:carly_silo) { Merchant.create!(name: "Carly Simon's Candy Silo")}
      let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}

      let!(:carlys_discount1) {carly_silo.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)}
      let!(:carlys_discount2) {carly_silo.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)}
      let!(:carlys_discount3) {carly_silo.bulk_discounts.create!(percentage_discount: 40, quantity_threshold: 5)}

      it 'I see all of my bulk discounts including their percentage discount and quantity thresholds' do

        visit "/merchants/#{carly_silo.id}/dashboard"

        expect(page).to have_content("Discount ##{carlys_discount1.id}")
        expect(page).to have_content("Percentage Off: #{carlys_discount1.percentage_discount}")
        expect(page).to have_content("Quantity of Items: #{carlys_discount1.quantity_threshold}")
      end

      it 'And each bulk discount listed includes a link to its show page' do

        visit "/merchants/#{carly_silo.id}/dashboard"
        
        expect(page).to have_link('View this Discount')
        click_link('View this Discount')
        expect(current_path).to eq(path_fill_in)
      end

    end
  end
end
