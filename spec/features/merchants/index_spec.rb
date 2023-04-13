require 'rails_helper'

RSpec.describe 'Merchant Index Page', type: :feature do
  before(:each) do
    visit '/merchants'
  end

  it 'has a header' do
    expect(page).to have_content('Merchants Index')
  end

  it 'shows all the merchant names as links' do
  end
end