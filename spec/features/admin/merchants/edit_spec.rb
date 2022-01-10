require 'rails_helper'

RSpec.describe 'admin merchant update' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant, name: "Good Corp.")
    visit "/admin/merchants/#{@merchant.id}/edit"
  end

  it 'submits edit form and updates merchant info' do
    fill_in('Name', with: 'Evil Inc.')
    click_button('Save')

    expect(current_path).to eq("/admin/merchants/#{@merchant.id}")
    expect(page).to have_content("Evil Inc.")
    expect(page).to_not have_content("Good Corp.")
  end
end
