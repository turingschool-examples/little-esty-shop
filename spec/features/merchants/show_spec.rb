require 'rails_helper'

RSpec.describe 'Merchant show page' do
  before :each do
    @bercy = Merchant.create!(name: "Bercy Hamhands")
  end
  it "can see the name of the merchant at the merchant dashboard page" do
    visit "/merchants/#{@bercy.id}/dashboard"

    expect(page).to have_content(@bercy.name)
  end
end
