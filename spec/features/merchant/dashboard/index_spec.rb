require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index' do
  describe 'view' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: "Frank")
    end

    it 'Displays the name of the Merchant' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content(@merchant_1.name)
    end
  end
end
