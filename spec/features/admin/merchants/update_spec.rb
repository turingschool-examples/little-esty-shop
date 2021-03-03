require 'rails_helper'

describe 'When I visit a merchants admin show page' do
    before (:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
    end

  it 'Then I see a link to update the merchants information' do
    visit "/admin/merchants/#{@merchant_1.id}"

    expect(page).to have_button("Update Merchant")
    click_button("Update Merchant")
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")

  end

  it 'Then I am taken to that merchants admin show page (/admin/merchants/merchant_id)' do
    visit "/admin/merchants/#{@merchant_1.id}"

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content("#{@merchant_1.name}")
  end

  it "And I see a form filled in with the existing merchant attribute information" do
    visit "/admin/merchants/#{@merchant_1.id}"

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")

    click_button("Update Merchant")
    expect(page).to have_field('name')
    fill_in "name", :with => "New Merchant Name"
    click_button("Update Merchant")
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content("New Merchant Name")
  end
end
