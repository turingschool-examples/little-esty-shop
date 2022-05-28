require 'rails_helper'

RSpec.describe 'Merchant Show Dash' do
  before(:each) do
    @billman = Merchant.create!(name: "Billman")
  end
  it "has the name of the merchant on the page" do
    visit "/merchants/#{@billman.id}/dashboard"

    expect(page).to have_content(@billman.name)
  end

  it "has a link to merchant items index" do
    visit "/merchants/#{@billman.id}/dashboard"

    expect(page).to have_link("#{@billman.name}'s Items")

    click_link("#{@billman.name}'s Items")

    expect(page).to have_current_path("/merchants/#{@billman.id}/items")
  end

  xit "has a link to merchant invoices index" do
    visit "/merchants/#{@billman.id}/dashboard"

    expect(page).to have_link("#{@billman.name}'s Invoices")

    click_link("#{@billman.name}'s Invoices")

    expect(page).to have_current_path("/merchants/#{@billman.id}/invoices")
  end
end
