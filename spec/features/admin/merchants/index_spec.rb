require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  it 'displays the names of each merchant in the system' do
    merchant1 = Merchant.create!(name: 'Trader Joes')
    merchant2 = Merchant.create!(name: 'Whole Foods')
    merchant3 = Merchant.create!(name: 'Yes Market')
    merchant4 = Merchant.create!(name: 'Pasta Emporium')

    visit admin_merchants_path

    within '#merchant-list' do
      expect(page).to have_content('Trader Joes')
      expect(page).to have_content('Whole Foods')
      expect(page).to have_content('Yes Market')
      expect(page).to have_content('Pasta Emporium')
    end
  end

  it 'when user clicks name of merchant, taken to that merchants admin show page, and shows the name of that merchant' do
    merchant1 = Merchant.create!(name: 'Trader Joes')
    merchant2 = Merchant.create!(name: 'Whole Foods')
    merchant3 = Merchant.create!(name: 'Yes Market')
    merchant4 = Merchant.create!(name: 'Pasta Emporium')

    visit admin_merchants_path

    within "#merchant-#{merchant1.id}" do
      click_link 'Trader Joes'
    end

    expect(current_path).to eq(admin_merchant_path(merchant1.id))

    expect(page).to have_content('Trader Joes')
  end
  it 'has a button to enable or disable each merchant' do
    merchant1 = Merchant.create!(name: 'Trader Joes')
    merchant2 = Merchant.create!(name: 'Whole Foods', status: 'Disabled')

    visit admin_merchants_path
    save_and_open_page
    within "#merchant-#{merchant1.id}" do
      expect(page).to have_button('Disable')
    end
    within "#merchant-#{merchant2.id}" do
      expect(page).to have_button('Enable')
    end
  end
  it 'clicking on enable/disable will update the merchant status and redirect to admin/merchants status and button will change' do
    merchant1 = Merchant.create!(name: 'Trader Joes')
    merchant2 = Merchant.create!(name: 'Whole Foods', status: 'Disabled')

    visit admin_merchants_path
    
    within "#merchant-#{merchant1.id}" do
      expect(page).to have_content('Enabled')
      expect(page).to have_button('Disable')
      click_on('Disable')
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button('Enable')
      expect(page).to have_content('Disabled')

    end
    within "#merchant-#{merchant2.id}" do
      expect(page).to have_content('Disabled')
      expect(page).to have_button('Enable')
      click_on('Enable')
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button('Disable')
      expect(page).to have_content('Enabled')
    end
  end
end
