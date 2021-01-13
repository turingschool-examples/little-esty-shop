require 'rails_helper'

describe "merchant items index" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
    @item_7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: @merchant1.id)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

    @item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
    @item_6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Coon')

    @invoice_1 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @invoice_2 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
    @invoice_3 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_6.id, status: 2)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1)
    @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
    @ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_5.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice_6.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_7.id)

    visit merchant_items_path(@merchant1)
  end

  it "can see a list of all the names of my items and not items for other merchants" do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
    expect(page).to have_content(@item_4.name)

    expect(page).to have_no_content(@item_5.name)
    expect(page).to have_no_content(@item_6.name)
  end

  it "has links to each item's show pages" do
    expect(page).to have_link(@item_1.name)
    expect(page).to have_link(@item_2.name)
    expect(page).to have_link(@item_3.name)
    expect(page).to have_link(@item_4.name)

    within("#enabled") do
      click_link "#{@item_1.name}"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/items/#{@item_1.id}")
    end
  end

  it "can make a button to disable items" do
    within("#item-#{@item_1.id}") do
      click_button "Disable"

      item = Item.find(@item_1.id)
      expect(item.status).to eq("disabled")
    end
    within("#item-#{@item_2.id}") do
      click_button "Enable"

      item = Item.find(@item_2.id)
      expect(item.status).to eq("enabled")
    end
    within("#item-#{@item_3.id}") do
      click_button "Enable"

      item = Item.find(@item_3.id)
      expect(item.status).to eq("enabled")
    end
  end

  it "has a section for disabled items" do
    within("#disabled") do
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_1.name)
    end
  end

  it "has a section for enabled items" do
    within("#enabled") do
      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
      expect(page).to have_content(@item_1.name)
    end
  end

  it "has a link to create a new item" do
    click_link "Create New Item"
    expect(current_path).to eq(new_merchant_item_path(@merchant1))
    fill_in "Name", with: "Bar Shampoo"
    fill_in "Description", with: "Eco friendly shampoo"
    fill_in "Unit price", with: "15"
    click_button "Submit"

    expect(current_path).to eq(merchant_items_path(@merchant1))

    within("#disabled") do
      expect(page).to have_content("Bar Shampoo")
    end
  end

  it "shows the top 5 most popular items by total revenue" do
    within("#top_5") do
      expect(@item_1.name).to appear_before(@item_2.name)
      expect(@item_2.name).to appear_before(@item_3.name)
      expect(@item_3.name).to appear_before(@item_8.name)
      expect(@item_8.name).to appear_before(@item_4.name)

      expect(page).to have_no_content(@item_7.name)
    end
  end

  it "links the top 5 to the item show page" do
    within("#top_5") do
      expect(page).to have_link(@item_1.name)
      expect(page).to have_link(@item_2.name)
      expect(page).to have_link(@item_3.name)
      expect(page).to have_link(@item_4.name)
      expect(page).to have_link(@item_8.name)

      click_link "#{@item_1.name}"
      expect(current_path).to eq(merchant_item_path(@merchant1, @item_1))
    end
  end

  it "shows the total revenue next to the item" do
    within("#top_5") do
      expect(page).to have_content("#{@merchant1.top_5_items[0].total_revenue}")
      expect(page).to have_content("#{@merchant1.top_5_items[1].total_revenue}")
      expect(page).to have_content("#{@merchant1.top_5_items[2].total_revenue}")
      expect(page).to have_content("#{@merchant1.top_5_items[3].total_revenue}")
      expect(page).to have_content("#{@merchant1.top_5_items[4].total_revenue}")
    end
  end

  it "shows the best day next to the item" do
    within("#top_5") do
      expect(page).to have_content("Top selling date for #{@item_1.name} was #{@item_1.best_day}")
      expect(page).to have_content("Top selling date for #{@item_2.name} was #{@item_2.best_day}")
      expect(page).to have_content("Top selling date for #{@item_3.name} was #{@item_3.best_day}")
      expect(page).to have_content("Top selling date for #{@item_4.name} was #{@item_4.best_day}")
      expect(page).to have_content("Top selling date for #{@item_8.name} was #{@item_8.best_day}")
    end
  end
end
