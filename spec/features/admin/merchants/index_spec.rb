require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  it 'shows all merchants' do
    count = Merchant.all.size
    visit '/admin/merchants'
    expect(page.all('.merchants li').count).to eq count
  end
end