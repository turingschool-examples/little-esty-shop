require 'rails_helper'

RSpec.describe 'dashboard show page' do
  it 'shows the name of my merchant' do
    merchant1 = create(:merchant)

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content(merchant1.name)
  end
end
