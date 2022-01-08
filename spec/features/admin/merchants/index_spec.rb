require 'rails_helper'

RSpec.describe 'admin merchants index' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @merchant1 = FactoryBot.create(:merchant)
    @merchant2 = FactoryBot.create(:merchant)
    @merchant3 = FactoryBot.create(:merchant)
    visit '/admin/merchants'
  end

  it 'shows the name of all merchants' do
    visit '/admin/merchants'
    expect(page).to have_content(@merchant.name)
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end
end
