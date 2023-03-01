require 'rails_helper'

RSpec.describe 'repo_name appears on all pages' do
	let!(:merchant1) { create(:active_merchant)}
	let!(:item1) {create(:item, merchant: merchant1, name: 'item 1')}
	let!(:customer1) { create(:customer)}
  let!(:invoice1) { create(:completed_invoice, customer: customer1, created_at: Date.new(2014, 4, 1))}
  
  it "show repo_name of 'little-esty-shop' on admin merchant show page" do
    visit "/admin/merchants/#{merchant1.id}"

    expect(page).to have_content("little-esty-shop")
  end

  it "show repo_name of 'little-esty-shop' on admin merchant index page" do
    visit "/admin/merchants"

    expect(page).to have_content("little-esty-shop")
  end

  it "show repo_name of 'little-esty-shop' on the merchant show page" do
    visit "/merchants/#{merchant1.id}"

    expect(page).to have_content("little-esty-shop")
  end

  it "show repo_name of 'little-esty-shop' merchant items index page" do
    visit "/merchants/#{merchant1.id}/items"
    expect(page).to have_content("little-esty-shop")
  end
end