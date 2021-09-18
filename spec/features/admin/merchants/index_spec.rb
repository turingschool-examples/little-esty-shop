require 'rails_helper'

RSpec.describe 'admin merchants index page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant) #Sprouts
    @merchant_2 = create(:merchant, name: "Jennys Jewels", status: "Enabled")
    @merchant_3 = create(:merchant, name: "Strawberry Prints")

    visit "/admin/merchants"
  end

  it 'displays all merchant names' do
    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_content(@merchant_1.name)
    end
    within("#merchant-#{@merchant_2.id}") do
      expect(page).to have_content(@merchant_2.name)
    end
    within("#merchant-#{@merchant_3.id}") do
      expect(page).to have_content(@merchant_3.name)
    end
  end

  it 'names link to show page' do
    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_link(@merchant_1.name)
    end
    within("#merchant-#{@merchant_2.id}") do
      expect(page).to have_link(@merchant_2.name)
    end
    within("#merchant-#{@merchant_3.id}") do
      expect(page).to have_link(@merchant_3.name)
    end
    click_on "Jennys Jewels"

    expect(current_path).to eq("/admin/merchants/#{@merchant_2.id}")
  end

  it 'has disable button for enabled merchants' do
    within("#merchant-#{@merchant_1.id}") do
      expect(page).to_not have_button('Disable')
    end
    within("#merchant-#{@merchant_2.id}") do
      expect(page).to have_button("Disable")
      click_on 'Disable'
    end
    within("#merchant-#{@merchant_2.id}") do
      expect(page).to_not have_button('Disable')
      expect(page).to have_button('Enable')
    end
  end

  it 'has enable button for disabled merchants' do
    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_button('Enable')
    end
    within("#merchant-#{@merchant_2.id}") do
      expect(page).to_not have_button("Enable")
    end
    within("#merchant-#{@merchant_3.id}") do
      expect(page).to have_button('Enable')
      click_on 'Enable'
    end
    within("#merchant-#{@merchant_3.id}") do
      expect(page).to_not have_button('Enable')
      expect(page).to have_button("Disable")
    end
  end
end
