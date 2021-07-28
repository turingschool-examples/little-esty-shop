require 'rails_helper'

RSpec.describe 'admin merchant show page' do
  before(:each) do
    @merchant = create(:merchant)

    visit admin_merchant_path(@merchant.id)
  end

  describe 'contents' do
    it 'displays the name of the merchant' do
      expect(page).to have_content(@merchant.name)
    end
  end
end
