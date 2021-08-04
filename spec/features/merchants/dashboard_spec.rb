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

    it 'show the items that are ready to ship with their invoice and date' do
      visit merchant_path(@merchant1.id)

      within('#ready_to_ship') do
        expect(page).to have_content('Items Ready to Ship')
        expect(page).to have_content('Potato Chips')
        expect(page).to have_content('Spinach')
        expect(page).to have_content('Red Bull')
        expect(page).to have_content('Hot Cheetos')
        expect(page).to have_content('Hot Dog')
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
