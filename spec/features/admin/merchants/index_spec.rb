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

end
