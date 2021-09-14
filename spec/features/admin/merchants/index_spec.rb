require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bob", id: 1, created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @merchant_2 = Merchant.create!(name: "Sara", id: 2, created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end

  it 'lists all merchants' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
  end
end
