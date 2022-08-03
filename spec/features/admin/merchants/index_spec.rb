require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Al Capone", created_at: Time.now, updated_at: Time.now)
    @merchant_2 = Merchant.create!(name: "Lucky Luciano", created_at: Time.now, updated_at: Time.now)
    @merchant_3 = Merchant.create!(name: "George Remus", created_at: Time.now, updated_at: Time.now)
  end

  it 'displays all of the merchants' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
  end
end
