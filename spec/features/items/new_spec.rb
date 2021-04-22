require 'rails_helper'

RSpec.describe 'the merchant item new page', type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Schroeder-Jerde')
  end

  # it 'shows the new item form' do
  #   visit "merchants/#{@merchant1.id}/items/new"
  #
  #   expect(find('form')).to have_content('Name')
  #   expect(find('form')).to have_content('Description')
  #   expect(find('form')).to have_content('Unit Price')
  #   expect(find('form')).to have_content('Status')
  #   expect(find('form')).to have_button('Submit New Item')
  # end

  describe 'happy path' do
    # it 'creates a new item into items index' do
    #   visit "merchants/#{@merchant1.id}/items/new"
    #
    #   fill_in "Name", with: "Test Item"
    #   fill_in "Description", with: "desc"
    #   fill_in "Unit Price", with: 1200
    #   fill_in "Status", with: "Enabled"
    #   click_button "Submit New Item"
    #   expect(current_path).to eq("merchants/#{@merchant1.id}/items")
    #     expect(page).to have_content("Test Item")
    # end

    describe 'sad path' do
      # it 'does not allow user to have empty attribute field' do
      #   visit "merchants/#{@merchant1.id}/items/new"
      #   fill_in "Description", with: "desc"
      #   click_button "Submit New Item"
      #   expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")
      #   expect(page).to have_content("ERROR: Item not created.")
      # end
    end
  end
end
