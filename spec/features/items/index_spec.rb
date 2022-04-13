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
      status: 1,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_2 = @customer_1.invoices.create!(
      status: 2,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_3 = @customer_2.invoices.create!(
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )

    @invoice_item_1 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_1.id,
      quantity: 1,
      unit_price: @soccer.unit_price,
      status: 1,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_item_2 = InvoiceItem.create!(
      item_id: @cup.id,
      invoice_id: @invoice_1.id,
      quantity: 50,
      unit_price: @cup.unit_price,
      status: 1,
      created_at: Date.current,
      updated_at: Date.current
    )
    @invoice_item_3 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_2.id,
      quantity: 500,
      unit_price: @soccer.unit_price,
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )

    @invoice_item_4 = InvoiceItem.create!(
      item_id: @beer.id,
      invoice_id: @invoice_3.id,
      quantity: 2,
      unit_price: @beer.unit_price * 2,
      status: 0,
      created_at: Date.current,
      updated_at: Date.current
    )

    @transaction_1 = @invoice_1.transactions.create!(
      credit_card_number:"4654405418249632",
      result: "success"
    )
    @transaction_2 = @invoice_2.transactions.create!(
      credit_card_number:"4654405418249632",
      result: "failed"
    )

    visit "/merchants/#{@merchant_1.id}/items"
  end

  it 'has a list of all of the merchants items' do
    expect(page).to have_content("Cup")
    expect(page).to have_content("Soccer Ball")
    expect(page).not_to have_content("Beer")
  end

  it 'has a button to create a new item' do
    click_button("Create a New Item")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
  end

  describe 'displays the merchants top 5 items' do
    before do
      @nothing = @merchant_1.items.create!(
        name: "nothing",
        description: "Not anything",
        unit_price: 999,
        created_at: Date.current,
        updated_at: Date.current
      )
      @lotion = @merchant_1.items.create!(
        name: "lotion",
        description: "Moisturize, kid.",
        unit_price: 50000,
        created_at: Date.current,
        updated_at: Date.current
      )
      @gnihton = @merchant_1.items.create!(
        name: "gnihton",
        description: "Seems to be word written backwards",
        unit_price: 1111111,
        created_at: Date.current,
        updated_at: Date.current
      )
      @something = @merchant_1.items.create!(
        name: "something",
        description: "Seems to be @something",
        unit_price: 37500,
        created_at: Date.current,
        updated_at: Date.current
      )

      @invoice_4 = @customer_1.invoices.create!(
        status: 1,
        created_at: Date.current,
        updated_at: Date.current
      )

      @invoice_item_5 = InvoiceItem.create!(
        item_id: @nothing.id,
        invoice_id: @invoice_4.id,
        quantity: 90,
        unit_price: @nothing.unit_price,
        status: 2,
        created_at: Date.current,
        updated_at: Date.current
      )
      @invoice_item_6 = InvoiceItem.create!(
        item_id: @gnihton.id,
        invoice_id: @invoice_4.id,
        quantity: 12,
        unit_price: @gnihton.unit_price,
        status: 2,
        created_at: Date.current,
        updated_at: Date.current
      )
      @invoice_item_7 = InvoiceItem.create!(
        item_id: @lotion.id,
        invoice_id: @invoice_4.id,
        quantity: 5,
        unit_price: @lotion.unit_price,
        status: 2,
        created_at: Date.current,
        updated_at: Date.current
      )
      @invoice_item_8 = InvoiceItem.create!(
        item_id: @something.id,
        invoice_id: @invoice_4.id,
        quantity: 5,
        unit_price: @something.unit_price,
        status: 2,
        created_at: Date.current,
        updated_at: Date.current
      )
      @transaction_3 = @invoice_4.transactions.create!(
        credit_card_number:"4654405418249632",
        result: "success"
      )

      visit "/merchants/#{@merchant_1.id}/items"
    end

    it 'displays them in order' do
      within('#top_five_items') do
        expect("gnihton").to appear_before("Cup")
        expect("Cup").to appear_before("lotion")
        expect("lotion").to appear_before("something")
        expect("something").to appear_before("nothing")

        expect(page).not_to have_content("Soccer Ball")
      end
    end

    it "displays the item's total revenue" do
      within("#top_item_#{@gnihton.id}") do
        expect(page).to have_content("Total revenue generated: $133333.32")
      end

      within("#top_item_#{@cup.id}") do
        expect(page).to have_content("Total revenue generated: $5000.0")
      end

      within("#top_item_#{@nothing.id}") do
        expect(page).to have_content("Total revenue generated: $899.1")
      end
    end
  end
end
