require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  it 'returns the name of each merchant in the system' do
    merchant1 = Merchant.create!(name: 'Chuckin Pucks')
    merchant2 = Merchant.create!(name: 'Daisys Daffodils')
    merchant3 = Merchant.create!(name: 'Gun Slingers')

    visit '/admin/merchants'

    expect(page).to have_content(merchant1.name)
    expect(page).to have_content(merchant2.name)
    expect(page).to have_content(merchant3.name)
  end
end