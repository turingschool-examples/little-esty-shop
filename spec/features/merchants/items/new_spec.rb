require 'rails_helper'

RSpec.describe 'New Merchant Item Spec' do
  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}

  it 'has a form to create a new item' do
    visit new_merchant_item_path(carly)

    expect(page).to have_field(:name)
    expect(page).to have_field(:description)
    expect(page).to have_field(:unit_price)
  end

  describe 'when I fill out the form and click submit' do
    it 'creates the item and redirects to merchant item index' do
      visit new_merchant_item_path(carly)

      fill_in(:name, with: "Zucchini Splendour")
      fill_in(:description, with: "Some stuff")
      fill_in(:unit_price, with: 250)
      click_on "Submit"

      expect(current_path).to eq(merchant_items_path(carly))

      expect(page).to have_content("Zucchini Splendour")
      expect(carly.items.last.enabled).to eq(false)
    end
  end
end