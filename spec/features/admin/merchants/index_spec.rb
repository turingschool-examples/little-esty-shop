require 'rails_helper'

RSpec.describe 'admin merchant index page' do

  before :each do
    @merchant1 = Merchant.create(name: "Robespierre")
    @merchant2 = Merchant.create(name: "BFranklin")
  end

  xit 'can display names of all merchants' do
    visit '/admin/merchants'

    expect(page).to have_content("Robespierre")
    expect(page).to have_content("BFranklin")
  end

  xit 'can click on merchant name and be redirected to that merchants show page' do
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

  xit 'can move them to the appropraite section of the page after disabling' do
    visit '/admin/merchants'

    within(".merchant_#{@merchant2.id}") do
      click_on 'Disable'
    end
    expect(current_path).to eq("/admin/merchants")

    within(".merchants_disabled") do
      expect(page).to have_content("#{@merchant2.name}")
    end
  end

  xit 'can move them to the appropraite section of the page after enabling' do
    visit '/admin/merchants'

    within(".merchant_#{@merchant2.id}") do
      click_on 'Disable'
    end

    within(".merchant_#{@merchant2.id}") do
      click_on 'Enable'
    end

    within(".merchants_enabled") do
      expect(page).to have_content("#{@merchant2.name}")
    end
  end
end
