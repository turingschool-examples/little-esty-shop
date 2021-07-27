require 'rails_helper'

RSpec.describe 'Merchants dashboard show page' do
  describe "dashboard" do
    before(:each) do
      @merchant_1 = create(:merchant)
      visit "/merchants/#{@merchant_1.id}/dashboard"
    end

    it 'can display merchant name' do
      expect(page).to have_content(@merchant_1.name)
    end
  end
end
