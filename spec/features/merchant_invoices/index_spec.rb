require 'rails_helper'

RSpec.describe 'the merchant invoices index' do

  describe 'display' do
    it 'shows header text' do
      visit merchant_invoices_path(@merchant1.id)

      within('#header') do
        expect(page).to have_content('My Invoices')
      end
    end

    it 'shows all invoices that include at least one merchant item' do
      visit merchant_invoices_path(@merchant1.id)

      within("#invoice-#{@invoice1.id}") do
        expect(page).to have_content("Invoice ##{@invoice1.id}")
      end

      within("#invoice-#{@invoice2.id}") do
        expect(page).to have_content("Invoice ##{@invoice2.id}")
      end

      within("#invoice-#{@invoice3.id}") do
        expect(page).to have_content("Invoice ##{@invoice3.id}")
      end

      within("#invoice-#{@invoice4.id}") do
        expect(page).to have_content("Invoice ##{@invoice4.id}")
      end

      within("#invoice-#{@invoice13.id}") do
        expect(page).to have_content("Invoice ##{@invoice13.id}")
      end

      within("#invoice-#{@invoice14.id}") do
        expect(page).to have_content("Invoice ##{@invoice14.id}")
      end
    end

    it 'does not show invoices without one of the merchants items' do
      visit merchant_invoices_path(@merchant1.id)

      expect(page).to_not have_content(@invoice5.id)
      expect(page).to_not have_content(@invoice6.id)
      expect(page).to_not have_content(@invoice7.id)
      expect(page).to_not have_content(@invoice8.id)
      expect(page).to_not have_content(@invoice9.id)
      expect(page).to_not have_content(@invoice10.id)
      expect(page).to_not have_content(@invoice11.id)
      expect(page).to_not have_content(@invoice12.id)
    end
  end
end
