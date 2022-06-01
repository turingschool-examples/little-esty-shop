require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index', type: :feature do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')
  end

  it 'should display the name of the merchant' do
    visit merchant_dashboard_index_path(@m1.id)

    within "#name" do
      expect(page).to have_content("Merchant 1")
    end
  end

  it 'should have links to merchant items index and merchant invoices index' do
    visit merchant_dashboard_index_path(@m1.id)
save_and_open_page
    expect(page).to have_link("My Items")
    expect(page).to have_link("My Invoices")
  end
end
