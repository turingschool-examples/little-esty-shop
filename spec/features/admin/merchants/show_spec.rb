require 'rails_helper'

RSpec.describe '', type: :feature do
  before do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
  end

  it "Show page has the merchants name." do
    visit "/admin/merchants/#{@merchant1.id}"
    expect(page).to have_content(@merchant1.name)
    expect(page).to_not have_content(@merchant2.name)
    expect(page).to_not have_content(@merchant3.name)
  end
end
