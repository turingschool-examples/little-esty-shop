require 'rails_helper'

RSpec.describe 'Merchant Items Edit Page' do
  before(:each) do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item = @merchant.items.create!(name: 'tem Qui Esse', description: 'nihil autem', unit_price: 75107)
  end

  it 'has a prepopulated form of respective item' do
    visit "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
    expect(page).to have_field('Name', with: 'tem Qui Esse')
    expect(page).to have_field('Description', with: 'nihil autem')
    expect(page).to have_field('Unit price', with: '75107')
  end

  # it 'can edit country attributes' do
  #   visit "/merchants/#{@merchant.id}/items/#{@item.id}"
  #
  #   fill_in(:country_name, with: "The Unified Hobbiathan State")
  #   fill_in(:nuclear_power, with: "false")
  #   fill_in(:military_power_rank, with: "5")
  #
  #   click_button("Update Country")
  #
  #   #save_and_open_page
  #
  #   expect(current_path).to eq("/countries/#{@country.id}")
  #   expect(page).to have_content("The Unified Hobbiathan State")
  # end

end
