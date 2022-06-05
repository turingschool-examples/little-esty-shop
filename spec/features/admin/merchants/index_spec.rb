require "rails_helper"

RSpec.describe 'Admin Merchant Index Page' do
  before :each do
    @billman = Merchant.create!(name: "Billman")
    @jacobs = Merchant.create!(name: "Jacobs")
  end

  it "shows the name of each merchant" do
    visit admin_merchants_path
    expect(page).to have_content(@jacobs.name)
    expect(page).to have_content(@billman.name)
  end

  it "has a link to show page for each merchant name" do
    visit admin_merchants_path
    click_link ("#{@jacobs.name}")
    expect(current_path).to eq(admin_merchant_path(@jacobs.id))
  end

  it "can update merchant status to enabled/disabled" do
    visit admin_merchants_path
    expect(page).to_not have_button("Enable")
    expect(page).to have_button("Disable", count: 2)

    click_button 'Disable', match: :first

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_button("Disable", count: 1)
    expect(page).to have_button("Enable", count: 1)
  end
end
