require 'rails_helper'

RSpec.describe 'Merchant Dashboard page' do
  context 'when i visit my merchant dashboard' do
    before(:each) do
      @sprouts = create(:merchant)
      visit "/merchants/#{@sprouts.id}/dashboard"
    end

    it 'shows the name of my merchant' do
      expect(page).to have_content('Sprouts')
    end
  end
end
