require 'rails_helper'

RSpec.describe 'Admin merchant show page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks', status: 'enabled')}
  let!(:merchant_2) {Merchant.create!(name: 'Merchant 2', status: 'enabled')}

  it 'show page is accessible with link from index page' do
    visit '/admin/merchants'
    click_link("#{merchant_1.name}")
  end

  it 'shows name for one merchant' do
    visit "/admin/merchants/#{merchant_1.id}"
    expect(page).to have_content("#{merchant_1.name}")
    expect(page).to_not have_content("#{merchant_2.name}")
  end

  it 'shows github info on current page' do
    visit "/admin/merchants/#{merchant_1.id}"
    github_service = GithubService.new

    expect(page).to have_content(github_service.repo_name)
    expect(page).to have_content("BrianZanti: 51\ndylan-harper: 49\nHenchworm: 42\ncroixk: 22\njacksonvaldez: 10\ntimomitchel: 9\nscottalexandra: 3\njamisonordway: 1\nMerged commits count: 82")
    expect(page).to have_content(github_service.all_merged)
  end

end
