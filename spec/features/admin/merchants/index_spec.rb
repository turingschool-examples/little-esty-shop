require 'rails_helper'

RSpec.describe 'admin merchant index page' do

  before :each do
    @merchant1 = Merchant.create(name: "Robespierre")
    @merchant2 = Merchant.create(name: "BFranklin")
  end

  it 'can display names of all merchants' do
    visit '/admin/merchants'

    expect(page).to have_content("Robespierre")
    expect(page).to have_content("BFranklin")
  end

  it 'can click on merchant name and be redirected to that merchants show page' do
    visit '/admin/merchants'
    click_on 'Robespierre'

    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
  end

end
