require 'rails_helper'

describe "Admin Merchants Index Page" do
  before :each do
    @merchants = create_list(:merchant,5)
    @disabled_merchants = create_list(:merchant,5,enabled: false)
    visit "/admin/merchants"
  end

  it "has a list of the name of each merchant in the system" do
    within(page.find("#all-merchants")) do
      expect(page).to have_content(@merchants[0].name)
      expect(page).to have_content(@merchants[1].name)
      expect(page).to have_content(@merchants[2].name)
      expect(page).to have_content(@merchants[3].name)
      expect(page).to have_content(@merchants[4].name)
    end
  end

  it "has a link for each merchant that redirects to that merchant's show page" do
    within(page.find("#all-merchants")) do
      click_on @merchants[0].name
      expect(current_path).to eq(admin_merchant_path(@merchants[0].id))
      visit "/admin/merchants"
      click_on @merchants[1].name
      expect(current_path).to eq(admin_merchant_path(@merchants[1].id))
    end
  end

  it "has buttons for enabling and disabling merchants" do
    within("#merchant-#{@merchants[0].id}") do
      expect(page).to have_content("Enabled")
      click_on "toggle-status"
    end

    within("#merchant-#{@merchants[0].id}") do
      expect(page).to have_content("Disabled")
      click_on "toggle-status"
    end

    within("#merchant-#{@merchants[0].id}") do
      expect(page).to have_content("Enabled")
    end
  end

  it "has a section for enabled and disabled merchants" do
    within("#enabled-merchants") do
      @merchants.each do |merchant|
        expect(page).to have_css("#merchant-#{merchant.id}")
      end
    end

    within("#disabled-merchants") do
      @disabled_merchants.each do |merchant|
        expect(page).to have_css("#merchant-#{merchant.id}")
      end
    end
  end

  it "has a link to create a new merchant" do
    click_on "New Merchant"
    expect(current_path).to eq(new_admin_merchant)
  end
end
