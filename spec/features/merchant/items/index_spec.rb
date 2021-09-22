require 'rails_helper'

RSpec.describe "merchant items index page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1, status: 1)
    @item_2 = create(:item, merchant: @merchant_1, status: 0)
    @item_3 = create(:item, merchant: @merchant_2, status: 1)
    @item_4 = create(:item, merchant: @merchant_2, status: 0)
  end

  it 'lists the names of all merchant items' do
    visit merchant_items_path(@merchant_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to_not have_content(@item_3.name)
    expect(page).to_not have_content(@item_4.name)

    visit merchant_items_path(@merchant_2)

    expect(page).to have_content(@item_3.name)
    expect(page).to have_content(@item_4.name)
    expect(page).to_not have_content(@item_1.name)
    expect(page).to_not have_content(@item_2.name)
  end

  it "has a link to create a new item on the item index page" do
    visit merchant_items_path(@merchant_1)

    expect(page).to have_content('Create New Item')

    click_link 'Create New Item'
  end

  it 'has a disable button' do
    visit merchant_items_path(@merchant_1)
    within("#enabled-#{@item_1.id}") do
      click_button("Disable")
    end
    within("#disabled-#{@item_1.id}") do
      expect(page).to have_content(@item_1.name)
    end
  end

  it 'has an enable button' do
    visit merchant_items_path(@merchant_1)
    within("#disabled-#{@item_2.id}") do
      click_button("Enable")
    end
    within("#enabled-#{@item_2.id}") do
      expect(page).to have_content(@item_2.name)
    end
  end

  describe 'top customer info' do
    before :each do
      @customer = create(:customer)

      @merchant = create(:merchant)
      @item_1 = create(:item, merchant: @merchant, name: 'A')
      @item_2 = create(:item, merchant: @merchant, name: 'B')
      @item_3 = create(:item, merchant: @merchant, name: 'C')
      @item_4 = create(:item, merchant: @merchant, name: 'D')
      @item_5 = create(:item, merchant: @merchant, name: 'E')
      @item_6 = create(:item, merchant: @merchant, name: 'F')
      @item_7 = create(:item, merchant: @merchant, name: 'G')
      @item_8 = create(:item, merchant: @merchant, name: 'H')
      @item_9 = create(:item, merchant: @merchant, name: 'I')

      @invoice_1 = create(:invoice, customer: @customer, created_at: "Thursday, September 15, 2021" )
      @transaction = create(:transaction, result: 'success', invoice: @invoice_1)
      @invoice_item_1 = create(:invoice_item, item: @item_1, status: 2, unit_price: 2, quantity: 2, invoice: @invoice_1)

      @invoice_2 = create(:invoice, customer: @customer, created_at: "Thursday, September 16, 2021")
      @transaction_2 = create(:transaction, result: 'success', invoice: @invoice_2)
      @invoice_item_2 = create(:invoice_item, item: @item_2, status: 0, unit_price: 2, quantity: 3, invoice: @invoice_2, created_at: "Wednesday, September 15, 2021")

      @invoice_3 = create(:invoice, customer: @customer, created_at: "Wednesday, September 15, 2021")
      @transaction_3 = create(:transaction, result: 'success', invoice: @invoice_3)
      @invoice_item_3 = create(:invoice_item, item: @item_3, status: 2, unit_price: 2, quantity: 4, invoice: @invoice_3)

      @invoice_4 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @transaction_4 = create(:transaction, result: 'success', invoice: @invoice_4)
      @invoice_item_4 = create(:invoice_item, item: @item_4, status: 2, unit_price: 2, quantity: 5, invoice: @invoice_4)

      @invoice_5 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @transaction_5 = create(:transaction, result: 'success', invoice: @invoice_5)
      @invoice_item_5 = create(:invoice_item, item: @item_5, status: 2, unit_price: 2, quantity: 6, invoice: @invoice_5)

      @invoice_6 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @transaction_6 = create(:transaction, result: 'failed', invoice: @invoice_6)
      @invoice_item_6 = create(:invoice_item, item: @item_6, status: 2, unit_price: 100, quantity: 200, invoice: @invoice_6)

      @invoice_7 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @transaction_7 = create(:transaction, result: 'failed', invoice: @invoice_7)
      @invoice_item_7 = create(:invoice_item, item: @item_7, status: 2, unit_price: 0, quantity: 0, invoice: @invoice_7)

      @invoice_8 = create(:invoice, customer: @customer, created_at: "Friday, September 17, 2021" )
      @transaction_8 = create(:transaction, result: 'success', invoice: @invoice_8)
      @invoice_item_8 = create(:invoice_item, item: @item_1, status: 2, unit_price: 2, quantity: 2, invoice: @invoice_8)

      @invoice_9 = create(:invoice, customer: @customer, created_at: "Sunday, September 13, 2021" )
      @transaction_9 = create(:transaction, result: 'success', invoice: @invoice_9)
      @invoice_item_9 = create(:invoice_item, item: @item_1, status: 2, unit_price: 2, quantity: 10, invoice: @invoice_9)

    end
    it "can list the top 5 most popular items ranked by total revenue" do
      visit merchant_items_path(@merchant)

      within("#top_five") do
        expect(@item_5.name).to appear_before(@item_4.name)
        expect(@item_4.name).to appear_before(@item_3.name)
        expect(@item_3.name).to appear_before(@item_2.name)
        # expect(@item_2.name).to appear_before(@item_1.name)
        expect(page).to have_content("$10")
        click_link @item_5.name
      end
      expect(current_path).to eq(merchant_item_path(@merchant, @item_5))
    end

#     When I visit the items index page
# Then next to each of the 5 most popular items I see the date with the most sales for each item.
# And I see a label “Top selling date for was "
#
# Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.

    it 'shows date of most sales for each item' do
      visit merchant_items_path(@merchant)
      expect(page).to have_content("Top selling date for A was 09/13/21")
      expect(page).to have_content("Top selling date for B was 09/16/21")
      expect(page).to have_content("Top selling date for C was 09/15/21")
      expect(page).to have_content("Top selling date for D was 09/14/21")
      expect(page).to have_content("Top selling date for E was 09/14/21")
    end
  end
end
