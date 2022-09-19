require 'rails_helper'

RSpec.describe 'New Merchant' do
  before(:each) {visit new_admin_merchant_path}
  it 'has a form to create a new merchant' do
    expect(page).to have_field(:name)
  end

  describe 'when I fill out the form and click submit' do
    it 'creates the item and redirects to admin merchant index' do
      fill_in(:name, with: "Hats For Dogs!")
      click_on "Submit"

      expect(current_path).to eq(admin_merchants_path)

      expect(page).to have_content("Hats For Dogs!")
      expect(Merchant.last.enabled).to eq(false)
    end
  end
end