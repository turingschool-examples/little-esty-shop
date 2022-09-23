require 'rails_helper'

RSpec.describe 'merchant bulk discount show page', type: :feature do
  describe 'As a visitor' do
    describe 'When I visit my bulk discount show page' do
      let!(:carly_silo) { Merchant.create!(name: "Carly Simon's Candy Silo")}
      let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}

      let!(:carlys_discount1) {carly_silo.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)}
      let!(:carlys_discount2) {carly_silo.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)}
      let!(:carlys_discount3) {carly_silo.bulk_discounts.create!(percentage_discount: 40, quantity_threshold: 5)}

      it "Then I see the bulk discount's quantity threshold and percentage discount" do

        visit merchant_bulk_discount_path(carly_silo)
        expect(page).to have_content("#{carlys_discount1.percentage_discount}")
        expect(page).to have_content("#{carlys_discount1.quantity_threshold}")
        expect(page).to_not have_content("#{carlys_discount2.percentage_discount}")
        expect(page).to_not have_content("#{carlys_discount2.quantity_threshold}")
      end

    end
  end
end
