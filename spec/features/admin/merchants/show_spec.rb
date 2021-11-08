require 'rails_helper'
# FactoryBot.find_definitions

RSpec.describe "merchant admin show page" do
  before :each do
    @merchant = create(:merchant)
  end

  it 'displays the merchants name' do
    visit "/admin/merchants/#{@merchant.id}"

    expect(page).to have_content(@merchant.name)
  end
end
