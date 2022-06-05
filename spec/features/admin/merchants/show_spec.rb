require 'rails_helper'

RSpec.describe 'admin merchant show page' do
  it 'shows the name of the merchant' do
    @merch1 = Merchant.create!(name: 'Floopy Fopperations')

    visit "/admin/merchants/#{@merch1.id}"

    expect(page).to have_content('Name: Floopy Fopperations')
  end

  it 'can update the merchant' do
    @merch1 = Merchant.create!(name: 'Floopy Fopperations')

    visit "/admin/merchants/#{@merch1.id}"

    click_link('Update Merchant')

    expect(current_path).to eq("/admin/merchants/#{@merch1.id}/edit")

    fill_in 'Name', with: 'Cherry Chidona'

    click_on('Save')

    expect(current_path).to eq("/admin/merchants/#{@merch1.id}")

    expect(page).to have_content('Merchant has been successfully updated!')

    expect(page).to have_content('Name: Cherry Chidona')

    expect(page).to_not have_content('Name: Floopy Fopperations')
  end
end
