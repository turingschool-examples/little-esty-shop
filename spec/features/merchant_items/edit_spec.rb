require 'rails_helper'

RSpec.describe 'Merchant Item Edit Page' do


  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant Name')
    @item_1 = Item.create!(name: 'Couch', description: 'comfy couch', unit_price: '1000', merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Phone', description: 'its cool', unit_price: '500', merchant_id: @merchant_1.id)
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit"
  end

  it 'when edit form is submitted,  it updated the item' do
    fill_in(:name, with: 'New Couch Name')
    fill_in(:description, with: 'this one is more comfy')
    fill_in(:unit_price, with: '5000')
    click_button("Save Changes")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
    expect(page).to have_content("New Couch Name")
    expect(page).to have_content("this one is more comfy")
    expect(page).to have_content("5000")
    expect(page).to have_content("changes saved successfully") # Flash Message
  end

  it 'shows github info on current page' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit"
    github_service = GithubService.new


    expect(page).to have_content(github_service.repo_name)
    expect(page).to have_content("BrianZanti: 51\ndylan-harper: 49\nHenchworm: 42\ncroixk: 22\njacksonvaldez: 10\ntimomitchel: 9\nscottalexandra: 3\njamisonordway: 1\nMerged commits count: 82")
    expect(page).to have_content(github_service.all_merged)
  end

end
