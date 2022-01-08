require 'rails_helper'

RSpec.describe 'admin merchant show page' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)

    visit "/admin/merchants/#{@merchant.id}"
  end

  it 'shows the name of merchant' do
    expect(page).to have_content(@merchant.name)
  end
end
