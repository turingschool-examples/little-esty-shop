require 'rails_helper'

RSpec.describe 'Merchants Items Index page' do
  before(:each) do

    @customers = []
    @invoices = []
    @items = []
    @transactions = []
    @invoice_items = []

    @merchant_1 = create(:merchant)
    5.times do
      @customers << create(:customer)
      @invoices << create(:invoice, customer_id: @customers.last.id)
      @items << create(:item, merchant_id: @merchant_1.id)
      @transactions << create(:transaction, invoice_id: @invoices.last.id)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1)
    end

    visit "/merchants/#{@merchant_1.id}/items"
  end

  it "lists the names of all this merchants items" do
    expect(page).to have_content(Item.first.name)
    expect(page).to have_content(Item.second.name)
    expect(page).to have_content(Item.third.name)
  end

  it "does not have items from other merchants" do
    merchant_2 = create(:merchant)
    items = create(:item, name: "Please Not This", merchant_id: merchant_2.id)

    expect(page).to_not have_content(Item.last.name)
  end

  it 'displays button to enable/disable item and sorts into the correct section' do
    merchant_2 = create(:merchant)
    items = create(:item, name: "Please Not This", merchant_id: merchant_2.id)
    items_2 = create(:item, name: "Rubber Chop Sticks", merchant_id: merchant_2.id)

    visit "/merchants/#{merchant_2.id}/items"

    expect(page).to have_button("Disable #{items.name}")
    expect(page).to have_button("Disable #{items_2.name}")
    click_on "Disable #{items.name}"
    #use within block?

    expect(current_path).to eq("/merchants/#{merchant_2.id}/items")
    # expect(items.enabled).to eq("disabled")  #Controller doesnt update :enabled on database
    expect(page).to have_button("Enable #{items.name}")
  end

  it "displays the top 5 most popular items" do
    @customers << create(:customer)
    @invoices << create(:invoice, customer_id: @customers.last.id)
    @items << create(:item, merchant_id: @merchant_1.id, unit_price: 1)
    @transactions << create(:transaction, invoice_id: @invoices.last.id)
    @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1, quantity: 1, unit_price: @items.last.unit_price)
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_content(@items[0].name)
    expect(page).to have_content(@items[1].name)
    expect(page).to have_content(@items[3].name)

    item3_rev = (@invoice_items[3].unit_price * @invoice_items[3].quantity).to_f/100
    item1_rev = (@invoice_items[1].unit_price * @invoice_items[1].quantity).to_f/100
    item0_rev = (@invoice_items[0].unit_price * @invoice_items[0].quantity).to_f/100

    expect(page).to have_content(item3_rev)
    expect(page).to have_content(item1_rev)
    expect(page).to have_content(item0_rev)

    within("#Top") do
      expect(page).to_not have_content(@items.last.name)
    end
  end

  it "can link to the item show page" do
    @customers << create(:customer)
    @invoices << create(:invoice, customer_id: @customers.last.id)
    @items << create(:item, merchant_id: @merchant_1.id, unit_price: 99999, name: "Big Chungus")
    @transactions << create(:transaction, invoice_id: @invoices.last.id)
    @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1, quantity: 1000, unit_price: @items.last.unit_price)
    visit "/merchants/#{@merchant_1.id}/items"

    within("#Top") do
      click_link "#{@items.last.name}"
    end

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@items.last.id}")
  end

  it 'has link to create a new item' do
    click_link "Create Item"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
  end

  describe "creates new item" do
    before(:each) do
      click_link "Create Item"

      fill_in "name", with: "Mamba"
      fill_in "description", with: "some random Yoda quote"
      fill_in "unit_price", with: 199
    end
    it "Allows you to fill out the form" do
      click_button "Submit"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
      expect(page).to have_content("Mamba")
    end

    it "see the new item in list of items with default value of disbaled" do
      click_button "Submit"

      expect(Item.last.enabled).to eq("disabled")
    end
  end
  # describe '#best_revenue_day' do
  #   it 'displays #best_revenue_day for each item' do
  #     InvoiceItem.destroy_all
  #     Item.destroy_all
  #     Transaction.destroy_all
  #     Invoice.destroy_all
  #     Customer.destroy_all
  #     Merchant.destroy_all
  #     customers2 = []
  #     invoices2 = []
  #     items2 = []
  #     transactions2 = []
  #     invoice_items2 = []
  #
  #     merchant_2 = create(:merchant)
  #
  #     customers2 << create(:customer)
  #     customers2 << create(:customer)
  #     customers2 << create(:customer)
  #     customers2 << create(:customer)
  #     customers2 << create(:customer)
  #
  #     items2 << create(:item, merchant_id: merchant_2.id, enabled: 0)
  #     items2 << create(:item, merchant_id: merchant_2.id, enabled: 0)
  #     items2 << create(:item, merchant_id: merchant_2.id, enabled: 0)
  #     items2 << create(:item, merchant_id: merchant_2.id, enabled: 0)
  #     items2 << create(:item, merchant_id: merchant_2.id, enabled: 0)
  #     invoices2 << create(:invoice, customer_id: customers2[0].id, status: 2, created_at: DateTime.new(2020,1,3,4,5,6))
  #     invoices2 << create(:invoice, customer_id: customers2[1].id, status: 2, created_at: DateTime.new(2019,2,3,4,5,6))
  #     invoices2 << create(:invoice, customer_id: customers2[2].id, status: 2, created_at: DateTime.new(2018,3,3,4,5,6))
  #     invoices2 << create(:invoice, customer_id: customers2[3].id, status: 2, created_at: DateTime.new(2017,4,3,4,5,6))
  #     invoices2 << create(:invoice, customer_id: customers2[4].id, status: 2, created_at: DateTime.new(2016,5,3,4,5,6))
  #
  #     transactions2 << create(:transaction, invoice_id: invoices2[0].id)
  #     transactions2 << create(:transaction, invoice_id: invoices2[1].id)
  #     transactions2 << create(:transaction, invoice_id: invoices2[2].id)
  #     transactions2 << create(:transaction, invoice_id: invoices2[3].id)
  #     transactions2 << create(:transaction, invoice_id: invoices2[4].id)
  #     invoice_items2 << create(:invoice_item, item_id: items2[0].id, invoice_id: invoices2[0].id, status: 2, quantity: 4, unit_price: 10)
  #     invoice_items2 << create(:invoice_item, item_id: items2[1].id, invoice_id: invoices2[1].id, status: 2, quantity: 2, unit_price: 10)
  #     invoice_items2 << create(:invoice_item, item_id: items2[2].id, invoice_id: invoices2[2].id, status: 2, quantity: 3, unit_price: 10)
  #     invoice_items2 << create(:invoice_item, item_id: items2[3].id, invoice_id: invoices2[3].id, status: 2, quantity: 4, unit_price: 10)
  #     invoice_items2 << create(:invoice_item, item_id: items2[4].id, invoice_id: invoices2[4].id, status: 2, quantity: 1, unit_price: 10)
  #     @invoices = []
  #     within("#Top") do
  #       expect(page).to have_content(invoices2[0].created_at)
  #     end
  #   end
  # end
end
