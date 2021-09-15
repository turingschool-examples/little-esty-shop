require 'rails_helper'

# As an admin,
# When I click on the name of a merchant from the admin merchants index page,
# Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
# And I see the name of that merchant

RSpec.describe 'admin merchants show page' do
  it "has a link to the merchant and shows all items for a merchant" do
    merchant_1 = Merchant.create!(name: 'Weston')
    # item_1 = merchant_1.items.create!(name: 'coffee', description: 'yummy', unit_price: 5 )
    # item_2 = merchant_1.items.create!(name: 'bread', description: 'yummy', unit_price: 5 )

    visit "admin/merchants"

    click_link merchant_1.name

    expect(current_path).to eq("admin/merchants/#{merchant_1.id}")

    expect(page).to have_content(merchant_1.name)
  end
end
