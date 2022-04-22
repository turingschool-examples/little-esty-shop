require "rails_helper"

RSpec.describe "Admin Merchants Index", type: :feature do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
  end

  it "Has all merchants", :vcr do
    visit admin_merchants_path

    within("#merchants") do
      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_3.name)
      end
      within("#merchant-#{@merchant_2.id}") do
        expect(page).to_not have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_3.name)
      end
      within("#merchant-#{@merchant_3.id}") do
        expect(page).to_not have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_3.name)
      end
    end
  end

  it "Links from index to show page for each merchant", :vcr do
    visit admin_merchants_path

    within("#merchants") do
      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_link(@merchant_1.name, href: admin_merchant_path(@merchant_1))
        expect(page).to_not have_link(@merchant_2.name, href: admin_merchant_path(@merchant_2))
        expect(page).to_not have_link(@merchant_3.name, href: admin_merchant_path(@merchant_3))
      end
    end

    click_link(@merchant_1.name)

    expect(current_path).to eq(admin_merchant_path(@merchant_1))
  end

  it "Links from index to page for creation of new merchant", :vcr do
    visit admin_merchants_path

    expect(page).to have_link("Create New Merchant", href: new_admin_merchant_path)

    click_link("Create New Merchant")

    expect(current_path).to eq(new_admin_merchant_path)
  end

  it "Has buttons for each merchant to toggle enable/disable status", :vcr do
    visit admin_merchants_path

    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_link("Enabled")
      click_link("Enabled")
    end

    expect(current_path).to eq(admin_merchants_path)

    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_link("Disabled")
    end
  end

  it "Sorts merchants on enabled/disabled status", :vcr do
    merchant_4 = Merchant.create!(name: "This Is A Test Value", enabled: false)
    visit admin_merchants_path

    within("#enabled-merchants") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to_not have_content(merchant_4.name)
    end

    within("#disabled-merchants") do
      expect(page).to_not have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
      expect(page).to_not have_content(@merchant_3.name)
      expect(page).to have_content(merchant_4.name)
    end
  end

  it "Finds top 5 merchants", :vcr do
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)
    merchant_6 = create(:merchant)

    customer_1 = create(:customer)
    customer_2 = create(:customer)

    item_1 = create :item, {unit_price: 5, enabled: 0, merchant_id: @merchant_1.id}
    item_2 = create :item, {unit_price: 7, enabled: 0, merchant_id: @merchant_2.id}
    item_3 = create :item, {unit_price: 4, enabled: 0, merchant_id: @merchant_3.id}
    item_4 = create :item, {unit_price: 4, enabled: 0, merchant_id: merchant_4.id}
    item_5 = create :item, {unit_price: 8, enabled: 0, merchant_id: merchant_5.id}
    item_6 = create :item, {unit_price: 6, enabled: 0, merchant_id: merchant_6.id}

    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
    invoice_2 = Invoice.create!(customer_id: customer_2.id, status: 2)

    transaction_1 = Transaction.create!(credit_card_expiration_date: "0 Seconds From Now", credit_card_number: "12341234", invoice_id: invoice_1.id, result: 0)
    transaction_2 = Transaction.create!(credit_card_expiration_date: "0 Seconds From Now", credit_card_number: "56785678", invoice_id: invoice_2.id, result: 1)

    invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 4, unit_price: item_1.unit_price)
    invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 3, unit_price: item_2.unit_price)
    invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 8, unit_price: item_3.unit_price)
    invoice_item_4 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_4.id, quantity: 4, unit_price: item_4.unit_price)
    invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_5.id, quantity: 3, unit_price: item_5.unit_price)
    invoice_item_6 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_6.id, quantity: 3, unit_price: item_6.unit_price)

    visit admin_merchants_path

    within("#top_five_merchants") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to_not have_content(merchant_4.name)
      expect(page).to have_content(merchant_5.name)
      expect(page).to_not have_content(merchant_6.name)

      expect(@merchant_3.total_revenue.to_s).to appear_before(merchant_5.total_revenue.to_s)
      expect(merchant_5.total_revenue.to_s).to appear_before(@merchant_1.total_revenue.to_s)
      expect(@merchant_1.total_revenue.to_s).to_not appear_before(@merchant_3.total_revenue.to_s)
    end
  end
end
