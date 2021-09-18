require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bob",created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @merchant_2 = Merchant.create!(name: "Sara",created_at:" 2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC", status: 'disabled')
  end

  it 'lists all merchants' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
  end

  it 'has a link to the merchants show page' do
    visit '/admin/merchants'
    click_on(@merchant_1.name)
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")

    visit '/admin/merchants'
    click_on(@merchant_2.name)
    expect(current_path).to eq("/admin/merchants/#{@merchant_2.id}")
  end

  it 'has a link for new merchant' do
    visit '/admin/merchants'
    click_on("New Merchant")
    expect(current_path).to eq("/admin/merchants/new")
  end

  it 'has a button to disable the merchant' do
    visit '/admin/merchants'
    expect(page).to have_button('Disable Merchant')
    within "#merchant-#{@merchant_1.id}" do
      click_button('Disable Merchant')
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content('disabled')
    end
  end

  it 'has a button to enable the merchant' do
    visit '/admin/merchants'
    expect(page).to have_button('Disable Merchant')
    within "#merchant-#{@merchant_1.id}" do
      click_button('Enable Merchant')
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content('enabled')
    end
  end

  it 'has a section for enabled merchants' do
    
  end
end
