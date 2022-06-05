require 'rails_helper'

RSpec.describe 'admin merchant show page' do
  it 'shows the name of the merchant' do
    @merch1 = Merchant.create!(name: 'Floopy Fopperations')

    visit "/admin/merchants/#{@merch1.id}"

    expect(page).to have_content('Name: Floopy Fopperations')
  end
end
