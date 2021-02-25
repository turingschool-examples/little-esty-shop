require 'rails_helper'
describe 'Merchants New Page' do

  it 'sees and fills out form' do
    visit "/admin/merchants/new"

    fill_in 'Name', with: "Cameras"

    click_on 'Submit'
    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_link('Cameras')
    expect(page).to have_content('Disabled')
  end
end