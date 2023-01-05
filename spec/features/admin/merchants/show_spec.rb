require 'rails_helper'

RSpec.describe 'the admin merchants index' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
  end

  describe 'As an admin, When I visit an admin merchant show page' do
    it 'shows the attributes for the corresponding merchant' do
      visit admin_merchant_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)
    end
  end
end
