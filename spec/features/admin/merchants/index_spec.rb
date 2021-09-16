require 'rails_helper'

RSpec.describe 'admin merchants index page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant) #Sprouts
    @merchant_2 = create(:merchant, name: "Jennys Jewels")
    @merchant_3 = create(:merchant, name: "Strawberry Prints")

    visit "/admin/merchants"
  end

  it 'displays all merchant names' do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
  end
end
