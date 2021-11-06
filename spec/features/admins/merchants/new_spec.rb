require 'rails_helper'

RSpec.describe 'Admin Merchant Create' do
  it 'has a form to create a new merchant' do
    visit '/admin/merchants/new'

    fill_in :name, with: "Lesley's Ladle Emporium"
    click_button "Create Merchant"

    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_content("Lesley's Ladle Emporium")
  end
end
