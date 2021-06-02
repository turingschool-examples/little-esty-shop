require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  before :each do
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    @merchant3 = Merchant.create!(name: "Bob", status: 1)

    visit admin_merchants_path
  end

  it 'I see the name of each merchant in the system' do
    expect(current_path).to eq(admin_merchants_path)

    within "#merchant-#{@merchant1.id}" do
      expect(page).to have_content(@merchant1.name)
    end

    within "#merchant-#{@merchant2.id}" do
      expect(page).to have_content(@merchant2.name)
    end

    within "#merchant-#{@merchant3.id}" do
      expect(page).to have_content(@merchant3.name)
    end
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
end
