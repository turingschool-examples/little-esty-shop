require 'rails_helper'

describe 'Merchant Dashboard' do
  before do
    @merchant1 = Merchant.create!(name: "Sally's Nails")
    visit "/merchants/#{@merchant1.id}/dashboard"
  end

  it 'displays merchant name' do
    expect(page).to have_content(@merchant1.name)
  end
end
