require 'rails_helper'
# FactoryBot.find_definitions

RSpec.describe "merchant admin show page" do
  before :each do
    @merchant = create(:merchant)
  end

  it 'displays the merchants name' do
    visit "/admin/merchants/#{@merchant.id}"

    expect(page).to have_content(@merchant.name)
  end


  it 'links to a merchant edit page' do
    visit "admin/merchants/#{@merchant.id}"

    click_link("Update #{@merchant.name}")

    expect(current_path).to eq("admin/merchants/#{@merchant.id}/edit")
  end
end
