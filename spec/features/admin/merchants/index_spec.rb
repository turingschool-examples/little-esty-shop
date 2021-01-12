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
    expect(current_path).to eq(new_admin_merchant_path)
  end

  it "has the top 5 merchants by revenue" do
    merchants = []
    7.times do |i|
      merchants[i] = create(:merchant)
      invoice1 = create(:invoice, merchant_id: merchants[i].id)
      item1 = create(:item, merchant_id: merchants[i].id)
      invoice_item1 = create(:invoice_item, quantity: 1, unit_price: 100000-100*i, invoice_id: invoice1.id, item_id: item1.id)
      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 0)
    end
    visit admin_merchants_path
    expected_top = Merchant.top_merchants(5)
    expected_top.each do |merchant|
      within("#top-merchants") do
        within("#merchant-#{merchant.id}") do
          expect(page).to have_content(merchant.name)
          expect(page).to have_content(merchant.total_revenue/100)
          expect(page).to have_content("Top selling date for #{merchant.name} was #{merchant.best_day}")
        end
      end
    end
    4.times do |i|
      within("#top-merchants") do
        expect(merchants[i].name).to appear_before(merchants[i+1].name)
      end
    end
  end
end
