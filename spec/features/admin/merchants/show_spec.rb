require 'rails_helper'

describe 'When I visit the admin merchants (/admin/merchants)' do
    #i need to creat items
    #i need to merchants
    #i need to create Itemmerchants
    before (:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
    end

  it 'When I click on the name of a merchant from the admin merchants index page' do
    visit "/admin/merchants"

    expect(page).to have_content("#{@merchant_1.name}")
    expect(page).to have_link("#{@merchant_1.name}")
    expect(page).to have_content("#{@merchant_2.name}")
    expect(page).to have_link("#{@merchant_2.name}")
    expect(page).to have_content("#{@merchant_3.name}")
    expect(page).to have_link("#{@merchant_3.name}")
    save_and_open_page

  end

  it 'Then I am taken to that merchants admin show page (/admin/merchants/merchant_id)' do
    visit "/admin/merchants"

    expect(page).to have_link("#{@merchant_1.name}")
    click_link("#{@merchant_1.name}")
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content("#{@merchant_1.name}")
  end
end
