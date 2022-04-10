require 'rails_helper'

RSpec.describe "Admin Merchants Index" do
  it 'displays a header showing the Admin Merchants Index' do
    visit '/admin/merchants'

    within(".header") do
      expect(page).to have_content("Merchant Index - Admin")
    end
  end

  it 'displays all of the merchants' do
    visit '/admin/merchants'

    within(".index") do
      expect(page).to have_content(@merchants)
    end
  end
end
