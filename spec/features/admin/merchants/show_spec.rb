require 'rails_helper'

RSpec.describe 'admin merchant show page' do

  it 'has as a link to update the merchant\'s information, which takes the user to a page to edit the merchant' do

    merchant1 = Merchant.create!(name: "Trader Joes")

    visit admin_merchant_path(merchant1)

    click_link "Update Merchant"

    expect(current_path).to eq("/admin/merchants/#{merchant1.id}/edit")

  end

end

