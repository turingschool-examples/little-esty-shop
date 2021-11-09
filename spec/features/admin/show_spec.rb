require 'rails_helper'

RSpec.describe do
  it 'links from the admin index page' do
    merchant1 = Merchant.create!(name: 'Linda Belcher')

    visit admin_index_path
    save_and_open_page



  end
end

# As an admin,
# When I click on the name of a merchant from the admin merchants index page,
# Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
# And I see the name of that merchant
