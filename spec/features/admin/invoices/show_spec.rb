require "rails_helper"

RSpec.describe "Admin Invoice Show", type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @items = create_list(:item, 4, merchant: @merchant1)
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @invoice1 = create(:invoice, customer: @customer1)
    @invoice2 = create(:invoice, customer: @customer2)
    @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @items.first)
    @invoice_item2 = create(:invoice_item, invoice: @invoice1, item: @items.second)
    @invoice_item3 = create(:invoice_item, invoice: @invoice2, item: @items.third)
    @invoice_item4 = create(:invoice_item, invoice: @invoice2, item: @items.last)
    @bulk_discounts = create_list(:bulk_discount, 3, merchant: @merchant1)
  end

  it "Shows the attributes for the selected invoice" do
    visit "/admin/invoices/#{@invoice1.id}"

    within("#invoice-info") do
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %e, %Y"))
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
      expect(page).to_not have_content(@invoice2.id)
      expect(page).to_not have_content(@customer2.first_name)
      expect(page).to_not have_content(@customer2.last_name)
    end
  end

  it "Shows the attributes for the invoice items on the selected invoice" do
    visit "/admin/invoices/#{@invoice1.id}"

    within("#invoice_items-#{@invoice_item1.id}") do
      expect(page).to have_content(@items.first.name)
      expect(page).to have_content(@invoice_item1.quantity)
      expect(page).to have_content(@invoice_item1.unit_price)
      expect(page).to have_content(@invoice_item1.status)
      expect(page).to_not have_content(@items.second.name)
    end

    within("#invoice_items-#{@invoice_item2.id}") do
      expect(page).to have_content(@items.second.name)
      expect(page).to have_content(@invoice_item2.quantity)
      expect(page).to have_content(@invoice_item2.unit_price)
      expect(page).to have_content(@invoice_item2.status)
      expect(page).to_not have_content(@items.first.name)
    end
  end

  it "Shows the total revenue for the selected invoice" do
    visit "/admin/invoices/#{@invoice1.id}"

    expected = (@invoice_item1.quantity * @invoice_item1.unit_price) + (@invoice_item2.quantity * @invoice_item2.unit_price)

    expect(page).to have_content(@invoice1.total_revenue)
    expect(@invoice1.total_revenue).to eq(expected)
  end

  it "Updates the invoice status to the status that is selected from the status select field" do
    @invoice1.update(status: "In Progress")
    visit admin_invoice_path(@invoice1.id)

    within("#invoice-info") do
      expect(page).to have_content("In Progress")
    end

    select "Completed"
    click_button "Update Invoice Status"

    expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
    expect(@invoice1.reload.status).to eq("Completed")
  end

  it 'Shows discounted revenue for the selected invoice' do
    merchant1 = create(:merchant)
    items = create_list(:item, 4, merchant: @merchant1)
    customer1 = create(:customer)
    customer2 = create(:customer)
    invoice1 = create(:invoice, customer: @customer1)
    invoice2 = create(:invoice, customer: @customer2)
    invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @items.first)
    invoice_item2 = create(:invoice_item, invoice: @invoice1, item: @items.second)
    invoice_item3 = create(:invoice_item, invoice: @invoice2, item: @items.third)
    invoice_item4 = create(:invoice_item, invoice: @invoice2, item: @items.last)
    bulk_discounts = create_list(:bulk_discount, 3, merchant: @merchant1)

    visit merchant_invoice_path(merchant1.id, invoice1.id)

    expected = ((invoice_item1.quantity * invoice_item1.unit_price) / invoice_item1.bulk_discount?) + ((invoice_item2.quantity * invoice_item2.unit_price) / invoice_item2.bulk_discount?)

    expect(page).to have_content(invoice1.discounted_revenue)
    expect(invoice1.discounted_revenue).to eq(expected)
  end
end
