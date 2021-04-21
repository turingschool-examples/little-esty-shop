require 'rails_helper'

RSpec.describe 'the merchant index', type: :feature do
  before(:each) do
    @jerde = Merchant.create!(name: 'Schroeder-Jerde')
    @willms = Merchant.create!(name: 'Willms and Sons')
    @thiel = Merchant.create!(name: 'Cummings-Thiel')
  end

  it 'lists of the names of all of merchants' do
    visit '/merchants'

    expect(page).to have_content(@jerde.name)
    expect(page).to have_content(@willms.name)
    expect(page).to have_content(@thiel.name)
  end     # not in a u.s.

  it "has a link to each merchant" do
    visit '/merchants'
    expect(page).to have_link(@jerde.name)
    expect(page).to have_link(@willms.name)
    expect(page).to have_link(@thiel.name)
  end
end     # not in a user story
