require 'rails_helper'

RSpec.describe 'Welcome Page' do
  before :each do
    visit '/'
  end

  it 'is on the correct paage' do
    expect(current_path).to eq('/')
    expect(page).to have_content('Welcome to our project!')
  end

  it 'can take user to merchants index page' do
    first(:link, 'Merchants').click

    expect(current_path).to eq('/merchants')
  end

  it 'can take the user to the admin dashboard page' do
    within("ul#dropdownmenu-admin") do
      click_on 'Dashboard'
      expect(current_path).to eq('/admin')
    end

  end

  it 'can take the user to the admin merchants index page' do
    within("ul#dropdownmenu-admin") do
      click_on 'Merchants'
      expect(current_path).to eq('/admin/merchants')
    end

  end

  it 'can take the user to the admin invoices index page' do
    within("ul#dropdownmenu-admin") do
      click_on 'Invoices'
      expect(current_path).to eq('/admin/invoices')
    end

  end

  it 'can take user to admin feeling lucky index page' do
    click_link 'Feeling Lucky 😎'

    expect(current_path).to eq('/')
  end
end
