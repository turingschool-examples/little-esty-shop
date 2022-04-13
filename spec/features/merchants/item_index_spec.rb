require 'rails_helper'

describe 'merchant item index page' do
  before do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
      created_at: Date.current,
      updated_at: Date.current
    )
    @merchant_2 = Merchant.create!(
      name: "Erots",
      created_at: Date.current,
      updated_at: Date.current
    )

    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10000,
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

    @beer = @merchant_2.items.create!(
      name: "Beer",
      description: "Happiness <3",
      unit_price: 100,
      created_at: Date.current,
      updated_at: Date.current
    )

    @customer_1 = Customer.create!(
      first_name: "Malcolm",
      last_name: "Jordan",
      created_at: Date.current,
      updated_at: Date.current
    )
    @customer_2 = Customer.create!(
      first_name: "Jimmy",
      last_name: "Felony",
      created_at: Date.current,
      updated_at: Date.current
    )

    @invoice_1 = @customer_1.invoices.create!(
      status: "0",
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_2 = @customer_1.invoices.create!(
      status: "1",
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_3 = @customer_2.invoices.create!(
      status: "0",
      created_at: Date.current,
      updated_at: Date.current
    )

    @invoice_item_1 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_1.id,
      quantity: 2,
      unit_price: @soccer.unit_price * 2,
      status: "0",
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_item_2 = InvoiceItem.create!(
      item_id: @cup.id,
      invoice_id: @invoice_1.id,
      quantity: 4,
      unit_price: @cup.unit_price * 4,
      status: "0",
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_item_3 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_2.id,
      quantity: 4,
      unit_price: @soccer.unit_price * 4,
      status: "2",
      created_at: Date.current,
      updated_at: Date.current
    )

    @invoice_item_4 = InvoiceItem.create!(
      item_id: @beer.id,
      invoice_id: @invoice_3.id,
      quantity: 2,
      unit_price: @beer.unit_price * 2,
      status: "0",
      created_at: Date.current,
      updated_at: Date.current
    )

    visit "/merchants/#{@merchant_1.id}/items"
  end

  it 'has a list of all of the merchants items' do
    expect(page).to have_content("Cup")
    expect(page).to have_content("Soccer Ball")
    expect(page).not_to have_content("Beer")
  end

  xit 'has a button to create a new item' do
    click_button("Create a New Item")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
  end

   it 'has a link to the item show page with the attributes' do
    click_on('Cup')
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@cup.id}")
    expect(page).to have_content('Cup')
    expect(page).to have_content('What the **** is this thing?')
    expect(page).to have_content('100')
  end

end
