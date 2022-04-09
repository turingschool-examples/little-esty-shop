require 'rails_helper'


RSpec.describe 'Merchant Dashboard Page' do

  before do

    @merch1 = Merchant.create!(name: 'Jeffs Gold Blooms', created_at: Time.now, updated_at: Time.now)
    @merch2 = Merchant.create!(name: 'Miyazakis Dark Souls', created_at: Time.now, updated_at: Time.now)
    visit "/merchants/#{@merch1.id}/dashboard"
  end

  describe 'As a Merchant' do

    it 'I visit my merchant dashboard, and see the name of my merchant' do
      expect(page).to have_content("Jeffs Gold Blooms")
      expect(page).to_not have_content('Miyazakis Dark Souls')
    end

    it 'I see a link to my merchant items index' do
      expect(page).to have_link("My Items")
    end

    it 'I see a link to my merchant invoice index' do
      expect(page).to have_link("My Invoices")
    end


  end

end
