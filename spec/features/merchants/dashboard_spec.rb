require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  describe 'as a merchant' do
    let!(:merchant_1) { Merchant.create!(name: "Johns Tools") }
    let!(:merchant_2) { Merchant.create!(name: "Hannas Hammocks") }
    
    describe 'User Story 1' do

        # As a merchant,
        # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
        # Then I see the name of my merchant

      it 'then I see the name of the merchant' do

        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)

        visit "/merchants/#{merchant_2.id}/dashboard"

        expect(page).to have_content(merchant_2.name)
        expect(page).to_not have_content(merchant_1.name)
      end
    end

    describe 'User Story 2' do

      # As a merchant,
      # When I visit my merchant dashboard
      # Then I see link to my merchant items index (/merchants/merchant_id/items)
      # And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)

      it 'Then I see link to my merchant items index (/merchants/merchant_id/items)' do
        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(find_link('Items Index')[:href].should == "/merchants/#{merchant_1.id}/items")

        visit "/merchants/#{merchant_2.id}/dashboard"

        expect(find_link('Items Index')[:href].should == "/merchants/#{merchant_2.id}/items")
      end

      it 'And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)' do
        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(find_link('Invoices Index')[:href].should == "/merchants/#{merchant_1.id}/invoices")

        visit "/merchants/#{merchant_2.id}/dashboard"

        expect(find_link('Invoices Index')[:href].should == "/merchants/#{merchant_2.id}/invoices")
      end
    end
  end
end
