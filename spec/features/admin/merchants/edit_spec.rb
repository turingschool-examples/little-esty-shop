require 'rails_helper'

RSpec.describe "merchant admin edit page" do
  before :each do
    @merchant = create(:merchant)
    visit "/admin/merchants/#{@merchant.id}/edit"
  end

  it 'allows admin to edit merchant' do
    expect(page).not_to have_content "Goldman Sachs"
    expect(page).to have_content "#{@merchant.name}"

    fill_in 'Name', with: "Goldman Sachs"
    save_and_open_page
    click_button "Submit"
    
    expect(current_path).to eq("/admin/merchants/#{@merchant.id}")
    expect(page).to have_content "Information has been successfully updated"

    expect(page).to have_content "Goldman Sachs"
    expect(page).not_to have_content "Jade Rabbit"
  end
end