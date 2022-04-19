require "rails_helper"

RSpec.describe "admin dashboard" do
  before :each do
      @merchant_1 = Merchant.create!(
      name: "Store Store",
      created_at: Date.current,
      updated_at: Date.current
    )
    @soccer = @merchant_1.items.create!(
      name: "Soccer Ball",
      description: "A ball of pure soccer.",
      unit_price: 32000,
      created_at: Date.current,
      updated_at: Date.current
    )
    @customer_1 = Customer.create!(
      first_name: "Malcolm",
      last_name: "Jordan",
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_1 = @customer_1.invoices.create!(
      status: 1,
      created_at: Date.new(2020,12,12),
      updated_at: Date.current
    )
    @invoice_2 = @customer_1.invoices.create!(
      status: 1,
      created_at: Date.new(2020,12,12),
      updated_at: Date.current
    )
    @invoice_3 = @customer_1.invoices.create!(
      status: 1,
      created_at: Date.new(1999,12,12),
      updated_at: Date.current
    )
    @invoice_4 = @customer_1.invoices.create!(
      status: 1,
      created_at: Date.new(2022,12,12),
      updated_at: Date.current
    )
    @invoice_item_1 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_1.id,
      quantity: 1,
      unit_price: @soccer.unit_price,
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )  
     @invoice_item_2 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_4.id,
      quantity: 50,
      unit_price: @soccer.unit_price,
      status: 1,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_item_3 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_3.id,
      quantity: 1,
      unit_price: @soccer.unit_price,
      status: 1,
      created_at: Date.current,
      updated_at: Date.current
    )  
     @invoice_item_4 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_2.id,
      quantity: 50,
      unit_price: @soccer.unit_price,
      status: 2,
      created_at: Date.current,
      updated_at: Date.current
    )
        visit "/admin"

  end

  it "exists" do
    expect(page).to have_content("Admin Dashboard")
  end

  it "has link to admin merchants index" do
    click_link("Admin Merchants Index")

    expect(current_path).to eq("/admin/merchants")
  end

  it "has link to admin invoices index" do
    click_link("Admin Invoices Index")
  
    expect(current_path).to eq("/admin/invoices")
  end

  it 'has an incomplete section' do
    within "#incomplete" do
      expect(page).to have_content("Incomplete Invoices")
      expect(page).to have_content("#{@invoice_1.id}")
      expect(page).to_not have_content("#{@invoice_2.id}")
    end 
  end 

  it ' has a link to show page'do 
    click_on("#{@invoice_1.id}")
    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.id}")
  end

  it 'incomplete section has a date' do
  expect(page).to have_content("Saturday, December 12, 2020")
  end 

  it  'Incomplete invoice items are organized by date' do
    within("#incomplete") do
      expect("1999").to appear_before("2020")
      expect("1999").to appear_before("2022")
    end 
  end 
end
