require 'rails_helper'

RSpec.describe 'the merchant dashboard' do
  describe 'display' do
    it 'shows the name of the merchant and links to items and invoices index' do
      visit merchant_path(@merchant1.id)

      within('#header') do
        expect(page).to have_content(@merchant1.name)
        expect(page).to have_selector(:link_or_button, "My Invoices")
        expect(page).to have_selector(:link_or_button, "My Items")
      end
    end
  end

  describe 'hyperlinks' do
    it 'links to merchant invoice and items index' do
      visit merchant_path(@merchant1.id)

      within('#header') do
        click_link 'My Invoices'

        expect(current_path).to eq(merchant_invoices_path(@merchant1.id))
      end

      visit merchant_path(@merchant1.id)

      within('#header') do
        click_link 'My Items'

        expect(current_path).to eq(merchant_items_path(@merchant1.id))
      end
    end
  end
end
