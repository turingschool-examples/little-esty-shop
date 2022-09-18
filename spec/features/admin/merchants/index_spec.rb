require 'rails_helper'

RSpec.describe 'admin merchant index page' do

  before :each do
    @merchant1 = Merchant.create(name: "Robespierre", status: 'Disabled')
    @merchant2 = Merchant.create(name: "BFranklin")
  end

  it 'can display names of all merchants' do
    visit '/admin/merchants'

    expect(page).to have_content("Robespierre")
    expect(page).to have_content("BFranklin")
  end

  it 'can click on merchant name and be redirected to that merchants show page' do
    visit '/admin/merchants'
      click_on 'Robespierre'

    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
  end

  it 'can disable a merchant' do
    visit '/admin/merchants'

    within(".merchant_#{@merchant2.id}") do
      click_on 'Disable'
    end

    expect(current_path).to eq("/admin/merchants")

    expect(page).to have_button("Enable")

  end

  it 'can enable a merchant' do
    visit '/admin/merchants'

    within(".merchant_#{@merchant2.id}") do
      click_on 'Disable'
    end

    within(".merchant_#{@merchant2.id}") do
      click_on 'Enable'
    end

    within(".merchant_#{@merchant2.id}") do
      expect(page).to have_button("Disable")
    end
  end

  it 'can move them to the appropraite section of the page after disabling' do
    merchant = Merchant.create(name: 'Some Guy', status: 'Enabled')
    visit '/admin/merchants'

    within(".merchant_#{merchant.id}") do
      click_on 'Disable'
    end
    expect(current_path).to eq("/admin/merchants")

    within(".merchants_disabled") do
      expect(page).to have_content("#{merchant.name}")
    end
  end

  it 'can move them to the appropraite section of the page after enabling' do
    merchant = Merchant.create(name: 'Some Guy', status: 'Enabled')
    visit '/admin/merchants'

    within(".merchant_#{merchant.id}") do
      click_on 'Disable'
    end

    within(".merchant_#{merchant.id}") do
      click_on 'Enable'
    end

    within(".merchants_enabled") do
      expect(page).to have_content("#{merchant.name}")
    end
  end

  it 'can group merchants by status' do
    merchant = Merchant.create(name: 'Some Guy', status: 'Enabled')
    merchant1 = Merchant.create(name: 'Another Person', status: 'Disabled')

    visit '/admin/merchants'

    within(".merchants_enabled") do
      expect(page).to have_content("Some Guy")
      expect(page).to_not have_content("Another Person")
    end

    within(".merchants_disabled") do
      expect(page).to have_content("Another Person")
      expect(page).to_not have_content("Some Guy")
    end
  end

  it 'can use button to get to new merchant page' do
    visit '/admin/merchants'

    click_button 'Add Merchant'

    expect(current_path).to eq('admin/merchants/new')
  end

end
