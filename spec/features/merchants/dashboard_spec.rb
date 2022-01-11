require 'rails_helper'

describe 'Merchant Dashboard' do
  before do
    @merchant_1 = Merchant.create!(name: 'Hair Care')

    visit "/merchants/#{@merchant_1.id}/dashboard"
  end

  describe 'display' do
    it 'displays merchant name' do
      expect(page).to have_content(@merchant_1.name)
    end

    it 'has a link to view all merchant items' do
      click_link "Merchant Items"
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    end

    it 'has a link to view all merchant invoices' do
      click_link "Merchant Invoices"
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
    end

    describe 'section for items ready to ship' do
      it 'list items, with their invoice id, that have not been shipped, in order' do
        within("#items_ready_to_ship") do
          expect(page).to have_content(@item1.name)
          expect(page).to have_content(@item1.invoice_id)
          expect(page).to have_content(@item2.name)
          expect(page).to have_content(@item2.invoice_id)
          expect(page).to_not have_content(@item3.name)
          expect(page).to_not have_content(@item3.invoice_id)
        end
      end

      it 'each invoice id is a link to merchant invoice show' do
        click_link @item1.invoice_id
        expect(current_path).to eq(merchant_invoice_path(@merchant, @item1))
      end
    end
  end
end
