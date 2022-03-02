require 'rails_helper'

RSpec.describe Item, type: :model do
  it {should belong_to :merchant}
  it {should have_many :invoice_items}
  it {should have_many(:invoices).through(:invoice_items)}

  it {should validate_presence_of :merchant_id}
  it {should validate_presence_of :name}
  it {should validate_presence_of :unit_price}
  it {should validate_presence_of :description}

  it {should validate_numericality_of :merchant_id}
  it {should validate_numericality_of :unit_price}

  describe 'class methods' do
    before(:each) do
      @merchant_1 = create(:merchant)
      #all items belong to merchant 1
      @item_1 = create(:item, merchant_id: @merchant_1.id, name: 'Stuffed Bear')
      @item_2 = create(:item, merchant_id: @merchant_1.id, name: 'Doll')
      @item_3 = create(:item, merchant_id: @merchant_1.id, name: 'Roller Skates')
      @item_4 = create(:item, merchant_id: @merchant_1.id, name: 'Yoyo')
      @item_5 = create(:item, merchant_id: @merchant_1.id, name: 'Coloring Book')
      @item_6 = create(:item, merchant_id: @merchant_1.id, name: 'Gift Card')
      # add invoice date for best day
      @invoice_1 = create(:invoice, created_at: '2012-03-21 14:54:09 UTC')
      @invoice_2 = create(:invoice, created_at: '2012-03-21 14:54:09 UTC')
      @invoice_3 = create(:invoice, created_at: '2012-03-23 14:54:09 UTC')
      @invoice_4 = create(:invoice, created_at: '2012-03-24 14:54:09 UTC')
      @invoice_5 = create(:invoice, created_at: '2012-03-25 14:54:09 UTC')
      @invoice_6 = create(:invoice, created_at: '2012-03-24 14:54:09 UTC')
      @invoice_7 = create(:invoice, created_at: '2012-03-23 14:54:09 UTC')
      # make revenue unique
      @invoice_item_1 = create(:invoice_item, unit_price: 30, quantity: 5, item: @item_1, invoice_id: @invoice_1.id)
      @invoice_item_2 = create(:invoice_item, unit_price: 30, quantity: 4, item: @item_1, invoice_id: @invoice_2.id)
      @invoice_item_3 = create(:invoice_item, unit_price: 50, quantity: 4, item: @item_2, invoice_id: @invoice_3.id)
      @invoice_item_4 = create(:invoice_item, unit_price: 40, quantity: 4, item: @item_3, invoice_id: @invoice_4.id)
      @invoice_item_5 = create(:invoice_item, unit_price: 20, quantity: 4, item: @item_4, invoice_id: @invoice_5.id)
      @invoice_item_6 = create(:invoice_item, unit_price: 90, quantity: 1, item: @item_5, invoice_id: @invoice_6.id)
      @invoice_item_7 = create(:invoice_item, unit_price: 240, quantity: 1, item: @item_6, invoice_id: @invoice_7.id)

      # transactions are successful linked to invoice item
      @transaction_1 = create(:transaction, invoice_id: @invoice_item_1.invoice_id)
      @transaction_2 = create(:transaction, invoice_id: @invoice_item_2.invoice_id)
      @transaction_3 = create(:transaction, invoice_id: @invoice_item_3.invoice_id)
      @transaction_4 = create(:transaction, invoice_id: @invoice_item_4.invoice_id)
      @transaction_5 = create(:transaction, invoice_id: @invoice_item_5.invoice_id)
      @transaction_6 = create(:transaction, invoice_id: @invoice_item_6.invoice_id)
      @transaction_7 = create(:transaction, invoice_id: @invoice_item_7.invoice_id)
      # $270 item 1, $200 item 2, $160 item 3, $80 item 4, $90 item 5, $240 item 6
    end

    it 'will list the names of the 5 most popular items ranked by total revenue' do

      expect(Item.most_popular_items(@merchant_1)).to eq([@item_1, @item_6, @item_2, @item_3, @item_5])
    end

    describe 'instance methods' do
      before(:each) do
        @merchant_1 = create(:merchant)
        #all items belong to merchant 1
        @item_1 = create(:item, merchant_id: @merchant_1.id, name: 'Stuffed Bear')
        @item_2 = create(:item, merchant_id: @merchant_1.id, name: 'Doll')
        @item_3 = create(:item, merchant_id: @merchant_1.id, name: 'Roller Skates')
        @item_4 = create(:item, merchant_id: @merchant_1.id, name: 'Yoyo')
        @item_5 = create(:item, merchant_id: @merchant_1.id, name: 'Coloring Book')
        @item_6 = create(:item, merchant_id: @merchant_1.id, name: 'Gift Card')
        # add invoice date for best day
        @invoice_1 = create(:invoice, created_at: '2012-03-21 14:54:09 UTC')
        @invoice_2 = create(:invoice, created_at: '2012-03-21 14:54:09 UTC')
        @invoice_3 = create(:invoice, created_at: '2012-03-23 14:54:09 UTC')
        @invoice_4 = create(:invoice, created_at: '2012-03-24 14:54:09 UTC')
        @invoice_5 = create(:invoice, created_at: '2012-03-25 14:54:09 UTC')
        @invoice_6 = create(:invoice, created_at: '2012-03-24 14:54:09 UTC')
        @invoice_7 = create(:invoice, created_at: '2012-03-23 14:54:09 UTC')
        # make revenue unique
        @invoice_item_1 = create(:invoice_item, unit_price: 30, quantity: 5, item: @item_1, invoice_id: @invoice_1.id)
        @invoice_item_2 = create(:invoice_item, unit_price: 30, quantity: 4, item: @item_1, invoice_id: @invoice_2.id)
        @invoice_item_3 = create(:invoice_item, unit_price: 50, quantity: 4, item: @item_2, invoice_id: @invoice_3.id)
        @invoice_item_4 = create(:invoice_item, unit_price: 40, quantity: 4, item: @item_3, invoice_id: @invoice_4.id)
        @invoice_item_5 = create(:invoice_item, unit_price: 20, quantity: 4, item: @item_4, invoice_id: @invoice_5.id)
        @invoice_item_6 = create(:invoice_item, unit_price: 90, quantity: 1, item: @item_5, invoice_id: @invoice_6.id)
        @invoice_item_7 = create(:invoice_item, unit_price: 240, quantity: 1, item: @item_6, invoice_id: @invoice_7.id)

        # transactions are successful linked to invoice item
        @transaction_1 = create(:transaction, invoice_id: @invoice_item_1.invoice_id)
        @transaction_2 = create(:transaction, invoice_id: @invoice_item_2.invoice_id)
        @transaction_3 = create(:transaction, invoice_id: @invoice_item_3.invoice_id)
        @transaction_4 = create(:transaction, invoice_id: @invoice_item_4.invoice_id)
        @transaction_5 = create(:transaction, invoice_id: @invoice_item_5.invoice_id)
        @transaction_6 = create(:transaction, invoice_id: @invoice_item_6.invoice_id)
        @transaction_7 = create(:transaction, invoice_id: @invoice_item_7.invoice_id)
        # $270 item 1, $200 item 2, $160 item 3, $80 item 4, $90 item 5, $240 item 6
      end

      it 'can show each items best day' do

        best_day = @item_1.best_day
        expect(best_day[0].created_at).to eq("2012-03-21 14:54:09")
      end
    end 
  end
end
