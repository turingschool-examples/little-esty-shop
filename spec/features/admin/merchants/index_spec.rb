require 'rails_helper'
describe 'Admin Merchant index page' do
  before :each do
    @merchants = []
    10.times {@merchants << create(:merchant)}
  end

  it 'Should list all merchant names' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchants[0].name)
    expect(page).to have_content(@merchants[1].name)
    expect(page).to have_content(@merchants[2].name)
    expect(page).to have_content(@merchants[3].name)
    expect(page).to have_content(@merchants[4].name)
    expect(page).to have_content(@merchants[5].name)
  end
end