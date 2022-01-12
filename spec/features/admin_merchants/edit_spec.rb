require 'rails_helper'

RSpec.describe 'Admin merchant edit page' do
  VCR.turn_off!


  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

  it 'allows merchant to be edited' do
    visit "/admin/merchants/#{merchant_1.id}"
    expect(page).to have_link("Update information")
    click_link("Update information")
    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}/edit")
    fill_in(:name, with: 'New merchant name')
    click_button("Save Changes")

    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
    visit ("/admin/merchants/#{merchant_1.id}")
    expect(page).to have_content("New merchant name")
    expect(page).to_not have_content("Billys Pet Rocks")

  end

  it 'shows github info on current page' do
    visit "/admin/merchants/#{merchant_1.id}"
    github_service = GithubService.new

    expect(page).to have_content(github_service.repo_name)
    expect(page).to have_content("BrianZanti: 51\ndylan-harper: 49\nHenchworm: 42\ncroixk: 22\njacksonvaldez: 10\ntimomitchel: 9\nscottalexandra: 3\njamisonordway: 1\nMerged commits count: 82")
    expect(page).to have_content(github_service.all_merged)
  end

end
