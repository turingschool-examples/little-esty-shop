require 'rails_helper'

RSpec.describe 'Admin Merchants index' do

  it 'Displays the name of each merchant' do
    visit admin_merchants_path

    expect(page).to have_content(Merchant.all.first.name)
    expect(page).to have_content(Merchant.all.fifth.name)
    expect(page).to have_content(Merchant.all.last.name)
  end

  it 'Has links to each merchant show page' do
    visit admin_merchants_path

    click_on(Merchant.all.first.name)

    expect(page).to have_content(Merchant.all.first.name)
    expect(page).to_not have_content(Merchant.all.last.name)
    expect(current_path).to eq(admin_merchant_path(Merchant.first.id))
  end

  it 'Has a button next to each merchant to enable or disable' do
    visit admin_merchants_path

    expect(Merchant.first.enabled?).to eq(true)
    within("#merchant_#{Merchant.first.id}") do
      click_button 'Disable'
    end

    expect(Merchant.first.enabled?).to eq(false)
    within("#merchant_#{Merchant.first.id}") do
      expect(page).to have_button('Enable')
    end

    click_button 'Enable'
  end

  it 'Has a button to create a new merchant' do
    visit admin_merchants_path

    click_button('Create a new merchant')
    expect(current_path).to eq(new_admin_merchant_path)
  end
  
  it 'Displays merchants by enabled true/false' do
    visit admin_merchants_path

    within "#enabled_merchants" do
      expect(page).to have_content(Merchant.first.name)
    end
    
    within "#disabled_merchants" do
      expect(page).to_not have_content(Merchant.first.name)
    end

    within "#merchant_#{Merchant.first.id}" do
      click_button 'Disable'
    end
    
    within "#disabled_merchants" do
      expect(page).to have_content(Merchant.first.name)
    end

    within "#enabled_merchants" do
      expect(page).to_not have_content(Merchant.first.name)
    end
    
    within "#merchant_#{Merchant.first.id}" do
      click_button 'Enable'
    end

    within "#enabled_merchants" do
      expect(page).to have_content(Merchant.first.name)
    end
  end
end