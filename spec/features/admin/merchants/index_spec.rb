require 'rails_helper'

RSpec.describe 'Admin Merchants Index Page' do
  before :each do
    # enabled
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    # disabled
    @merchant3 = Merchant.create!(name: "Bob", status: 0)

    visit admin_merchants_path
  end

  it "I click on the name of a merchant, which is a link that takes me to that merchant's admin show page" do
    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)

    click_link "#{@merchant1.name}"

    expect(current_path).to eq(admin_merchant_path(@merchant1))
    expect(page).to have_content(@merchant1.name)
    expect(page).to_not have_content(@merchant2.name)
    expect(page).to_not have_content(@merchant3.name)
  end

  it "I see the name of each merchant in their respective category of either 'Enabled' or 'Disabled'."  do
    expect(current_path).to eq(admin_merchants_path)
    # enabled
    within "#enabled-merchant-#{@merchant1.id}" do
      expect(page).to have_content(@merchant1.name)
    end

    within "#enabled-merchant-#{@merchant2.id}" do
      expect(page).to have_content(@merchant2.name)
    end
    # disabled
    within "#disabled-merchant-#{@merchant3.id}" do
      expect(page).to have_content(@merchant3.name)
    end
  end

  it "I can click a button to enable or disable a merchants status" do
    # enabled
    within "#enabled-merchant-#{@merchant1.id}" do
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button('Disable')

      click_button 'Disable'
    end

    within "#disabled-merchant-#{@merchant1.id}" do
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button('Enable')
    end


    # disabled
    within "#disabled-merchant-#{@merchant3.id}" do
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button('Enable')

      click_button 'Enable'
    end

    within "#enabled-merchant-#{@merchant3.id}" do
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button('Disable')
    end
  end

  it "I see a link to create a new merchant." do
    expect(page).to have_link('Create New Merchant', href: new_admin_merchant_path)
  end
end
