require 'rails_helper'

RSpec.describe 'admin merchant index page' do

  before :each do
    @merchant1 = Merchant.create(name: "Robespierre")
    @merchant2 = Merchant.create(name: "BFranklin")
  end

  it 'can display merchant name on show page' do
    visit"/admin/merchant/#{@merchant1.id}"

    expect(page).to have_content("Robespierre")
  end

end
