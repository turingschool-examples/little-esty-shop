require "rails_helper"

describe Item, type: :model do
  describe "relations" do
    it {should have_many :invoice_items}
    it {should have_many :invoices}
    it {should belong_to :merchant}
  end

  describe "scopes" do
    it 'enabled' do
      enabled_item = create(:item, enabled: true)
      disabled_item = create(:item, enabled: false)

      expect(Item.enabled).to include(enabled_item)
      expect(Item.enabled).not_to include(disabled_item)
    end

    it 'enabled' do
      enabled_item = create(:item, enabled: true)
      disabled_item = create(:item, enabled: false)

      expect(Item.disabled).to include(disabled_item)
      expect(Item.disabled).not_to include(enabled_item)
    end
  end

  describe 'class methods:' do
    it 'items_to_ship;' do
      merchant1 = create(:merchant)
      items = create_list(:item, 6, merchant: merchant1)
      items.first(4).each do |item|
        create(:invoice_item, item: item, status: 1)
      end

      expect(Item.items_to_ship.to_set).to eq(items.first(4).to_set)
    end

    describe 'popular_items' do
      before(:each) do
        @merchant1 = create(:merchant)
        @items = create_list(:item, 5, merchant: @merchant1, unit_price: 1)

        @items.each_with_index do |item, index|
          (5 - index).times do
            invoice = create(:invoice, items: [item])
            create(:invoice_item, item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: index + 10)
            create(:transaction, invoice_id: invoice.id, result: 0)
          end
        end

        no_transaction = create(:item, merchant: @merchant1)
      end

      it "selects the most popular items" do
        expect(Item.popular_items.to_set).to eq(@items.to_set)
      end

      it "only includes invoices with successful transactions" do
        unsuccessful = create(:item, merchant: @merchant1, unit_price: 1)
        6.times do
          invoice = create(:invoice, items: [unsuccessful])
          create(:transaction, invoice_id: invoice.id, result: 1)
        end

        expect(Item.popular_items).not_to include(unsuccessful)
      end

      it "considers the invoice_item's unit price rather than the item's" do
        popular_items = Item.popular_items
        expect(popular_items[0].total_revenue).to eq(50)
        expect(popular_items[1].total_revenue).to eq(44)
        expect(popular_items[2].total_revenue).to eq(36)
        expect(popular_items[3].total_revenue).to eq(26)
        expect(popular_items[4].total_revenue).to eq(14)
      end
    end
  end

  describe 'delegate methods:' do
    it 'top_sales_day' do
      merchant1 = create(:merchant)
      items = create_list(:item, 5, merchant: merchant1, unit_price: 1)

      5.times do |index|
        invoice = create(:invoice, created_at: Date.today - index)
        items[0..index].each do |item|
          create(:invoice_item, item: item, invoice: invoice, quantity: (5 - index), unit_price: 1)
        end
        create(:transaction, invoice: invoice, result: 0)
      end

      expect(items[0].top_sales_day).to eq(Date.today)
      expect(items[1].top_sales_day).to eq(Date.today - 1)
      expect(items[2].top_sales_day).to eq(Date.today - 2)
      expect(items[3].top_sales_day).to eq(Date.today - 3)
      expect(items[4].top_sales_day).to eq(Date.today - 4)
    end
  end
end
