require 'rails_helper'
RSpec.describe 'it shows the attributes of a certain merchant' do
  before :each do
    visit "/admin/merchants/#{@merchant1.id}"
  end
  it 'can click the link on the index page of a certain merchant and be taken to its show page' do
    visit "/admin/merchants"

    click_link("#{@merchant1.name}")

    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
  end

  it 'shows the name of the merchant on the Show page' do
    expect(page).to have_content(@merchant1.name)
    expect(page).to_not have_content(@merchant2.name)
  end
end