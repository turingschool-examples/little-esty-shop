require 'rails_helper'

RSpec.describe 'merchant items index page' do 
  describe 'when i visit my merchant items index page' do 
    before :each do 
      @klein_rempel = Merchant.create!(name: "Klein, Rempel and Jones")
      @whb = Merchant.create!(name: "WHB")
      @something= @klein_rempel.items.create!(name: "Something", description: "A thing that is something", unit_price: 300, status: "Enabled")
      @another = @klein_rempel.items.create!(name: "Another", description: "One more something", unit_price: 150, status: "Enabled")
      @other = @whb.items.create!(name: "Other", description: "One more something", unit_price: 150)
    end
    it 'i see a list of names of all my items but not those for other merchants' do 
      visit merchant_items_path(@klein_rempel)
      expect(page).to have_content("Something")
      expect(page).to have_content("Another")
      expect(page).to_not have_content("Other")
    end

    it 'next to each item is a button to disable/ enable item which takes user back to items index with items status changed' do 
      visit merchant_items_path(@klein_rempel)
      within "#item-enabled-#{@something.name}" do 
        save_and_open_page

        click_button "Enable"
        expect(page).to have_content("Disabled")
        expect(page).to_not have_content("Enabled")
        save_and_open_page
      end 

      # expect(page).to_not have_content("Enabled")
      # click_button "Enable"
      # expect(page).to have_content("Enabled")
      # expect(page).to_not have_content("Disabled")
    end

    it 'Each item is split into two categories on the page, enabled items and disabled' do 
      visit merchant_items_path(@klein_rempel)
    end

  

  end
end