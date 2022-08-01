require 'rails_helper'

RSpec.describe 'Admin Merchants Show Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Al Capone", created_at: Time.now, updated_at: Time.now)
    # @merchant_2 = Merchant.create!(name: "Lucky Luciano", created_at: Time.now, updated_at: Time.now)
    # @merchant_3 = Merchant.create!(name: "George Remus", created_at: Time.now, updated_at: Time.now)
  end

  it 'has a link to update the merchants information' do

    visit "/admin/merchants/#{@merchant_1.id}"

    click_link 'Update Merchant Information'

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")

  end



end
