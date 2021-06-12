require 'rails_helper'

RSpec.describe 'Admin Merchants Show Page' do
  before :each do
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    @merchant3 = Merchant.create!(name: "Bob", status: 1)

    visit admin_merchant_path(@merchant1)
  end

  it "I see the name of the merchant whos page I'm on." do
    expect(current_path).to eq(admin_merchant_path(@merchant1))
    expect(page).to have_content(@merchant1.name)
  end

  it "I see a link to update the merchant's information." do
    expect(current_path).to eq(admin_merchant_path(@merchant1))
    expect(page).to have_link('Update Merchant Information', href: edit_admin_merchant_path(@merchant1))
  end

  it "I can click link to update and get sent to edit page" do
    expect(current_path).to eq(admin_merchant_path(@merchant1))
    expect(page).to have_content(@merchant1.name)

    click_link 'Update Merchant Information'


    expect(current_path).to eq(edit_admin_merchant_path(@merchant1))
  end
end
