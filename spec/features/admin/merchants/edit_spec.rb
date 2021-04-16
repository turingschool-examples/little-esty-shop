require 'rails_helper'

RSpec.describe 'admin merchant edit page', type: :feature do
  it 'shows the merchant edit form' do
    merchant1 = Merchant.create!(name: "Abe")

    visit "/admin/merchants/#{merchant1.id}/edit"

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Update Merchant')
  end
end