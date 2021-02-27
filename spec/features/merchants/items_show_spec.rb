require "rails_helper"
require 'time'
RSpec.describe 'Merchant Items show page' do
  describe "It shows a link to update that current item" do
    it "when I click link I'm taken to a form to update existing attributes" do
      mer_1 = create(:merchant)
      item_1 = create(:item, name: "Original name", merchant_id: mer_1.id)
      visit(merchant_item_path(mer_1, item_1))
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_1.description)
      expect(page).to have_content(item_1.unit_price)
      expect(page).to have_link("Update this Item")
      click_link("Update this Item")
      #expect(page).to have_field("name", with: "#{item_1.name}")
      expect(page).to have_button("Edit Item")
    end
  end

  it "takes me back to items show page with updated information" do
    mer_1 = create(:merchant)
    item_1 = create(:item, name: "Original name", merchant_id: mer_1.id)
    visit(merchant_item_path(mer_1, item_1))
    click_link("Update this Item")
    fill_in("item[name]", with: "New Name")
    fill_in("item[description]", with: "New Description")
    fill_in("item[unit_price]", with: 10)
    click_button("Edit Item")
    expect(page).to have_content("New Name")
    expect(page).to have_content("Item Updated")
  end

  it "errors out if all fields are not filled in" do
    mer_1 = create(:merchant)
    item_1 = create(:item, name: "Original name", merchant_id: mer_1.id)
    visit(merchant_item_path(mer_1, item_1))
    click_link("Update this Item")
    fill_in("item[name]", with: "New Name")
    fill_in("item[description]", with: "New Description")
    fill_in("item[unit_price]", with: "New Description")
    click_button("Edit Item")
    expect(page).to have_content("Fill in unit price with integer, description with statement")
  end
end
