require 'rails_helper'

RSpec.describe "Admin Merchant Edit Page", type: :feature do

  before :each do
    @merchant_1 = create(:merchant)
  end

  it 'Updates a singular merchant name' do
    visit "/admin/merchants/#{@merchant_1.id}/edit"

    name = @merchant_1.name

    fill_in :name, with: "Isaac Childres"
    click_on :submit


    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")

    expect(page).to have_content("Isaac Childres")
    expect(page).to_not have_content(name)
  end
end