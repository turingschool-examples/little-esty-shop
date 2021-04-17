require 'rails_helper'

RSpec.describe 'Admin Merchant Create' do
  describe 'new merchant form' do
  it 'renders the new form' do
    visit '/admin/merchants'

    link_to 'Create new merchant'
    expect(current_path).to eq("/admin/merchants/new")

    #
    #   As an admin,
    # When I visit the admin merchants index
    # I see a link to create a new merchant.
    # When I click on the link,
    # I am taken to a form that allows me to add merchant information.
    # When I fill out the form I click ‘Submit’
    # Then I am taken back to the admin merchants index page
    # And I see the merchant I just created displayed
    # And I see my merchant was created with a default status of disabled.
