require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  before :each do
    @frank = Customer.create!(first_name: 'Frank', last_name: 'Enstein')

    @invoice_1 = @frank.invoices.create!(status: 2)
    @invoice_2 = @frank.invoices.create!(status: 2)
    @invoice_3 = @frank.invoices.create!(status: 2)

    @transaction_1 = @invoice_1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction_2 = @invoice_1.transactions.create!(result: 1, credit_card_number: 4580251236515201)
    @transaction_3 = @invoice_2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction_4 = @invoice_2.transactions.create!(result: 0, credit_card_number: 4515551623735607)
    @transaction_5 = @invoice_3.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction_6 = @invoice_3.transactions.create!(result: 1, credit_card_number: 4540842003561938)

    @merchant_1 = Merchant.create!(name: 'LittleHomeSlice')
    @item_1 = @merchant_1.items.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, status: 1)
    @item_2 = @merchant_1.items.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, status: 1)
    @item_3 = @merchant_1.items.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, status: 1)

    @merchant_2 = Merchant.create!(name: 'BreadNButter')
    @item_4 = @merchant_2.items.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.0, status: 0)
    @item_5 = @merchant_2.items.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.5, status: 0)
    @item_6 = @merchant_2.items.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.0, status: 0)
    @item_7 = @merchant_2.items.create!(name: 'Thing 7', description: 'This is the seventh thing.', unit_price: 11.5, status: 0)
    @item_8 = @merchant_2.items.create!(name: 'Thing 8', description: 'This is the eighth thing.', unit_price: 18.0, status: 0)
    @item_9 = @merchant_2.items.create!(name: 'Thing 9', description: 'This is the ninth thing.', unit_price: 17.0, status: 0)
    @item_10 = @merchant_2.items.create!(name: 'Thing 10', description: 'This is the tenth thing.', unit_price: 21.0, status: 0)

    @invoice_item_0 = @item_4.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 2, invoice: @invoice_1) #96.0  1
    @invoice_item_6 = @item_9.invoice_items.create!(quantity: 5, unit_price: 17.0, status: 2, invoice: @invoice_2) #85.0  1
    @invoice_item_3 = @item_6.invoice_items.create!(quantity: 7, unit_price: 10.0, status: 2, invoice: @invoice_2) #70.0  2
    @invoice_item_1 = @item_4.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 2, invoice: @invoice_2) #48.5  3
    @invoice_item_2 = @item_5.invoice_items.create!(quantity: 3, unit_price: 15.5, status: 2, invoice: @invoice_1) #46.5  4
    @invoice_item_4 = @item_7.invoice_items.create!(quantity: 4, unit_price: 11.5, status: 2, invoice: @invoice_2) #46.0  5

    @invoice_item_7 = @item_10.invoice_items.create!(quantity: 2, unit_price: 21.0, status: 2, invoice: @invoice_3) #42.0
    @invoice_item_5 = @item_8.invoice_items.create!(quantity: 1, unit_price: 18.0, status: 2, invoice: @invoice_3) #18.0
  end

  describe 'class methods' do
    describe '.enable/disable items' do
      it 'can group enabled items' do
        expect(Item.enable_items.first.name).to eq(@item_1.name)
        expect(Item.enable_items.second.name).to eq(@item_2.name)
        expect(Item.enable_items.third.name).to eq(@item_3.name)
        expect(Item.enable_items.last.name).to_not eq(@item_1.name)
      end

      it 'can group disabled items' do
        expect(Item.disable_items.first.name).to eq(@item_4.name)
        expect(Item.disable_items.third.name).to eq(@item_6.name)
        expect(Item.disable_items.fifth.name).to eq(@item_8.name)
        expect(Item.disable_items.last.name).to eq(@item_10.name)
        expect(Item.disable_items.last.name).to_not eq(@item_9.name)
      end
    end

    describe '.total revenue' do
      it 'can list top 5 most popular items ranked by total revenue generated' do
        expect(Item.top_popular_items.first.name).to eq(@item_4.name)
        expect(Item.top_popular_items.first.name).to_not eq(@item_7.name)
      end
    end
  end

  describe 'instance methods' do
    describe '#total revenue top date' do
      it 'can give the date with the most sales for each of the most popluar items' do
        expect(@item_4.items_top_selling_days).to eq("#{@item_4.created_at.strftime("%m/%d/%Y")}")
        expect(@item_4.items_top_selling_days).to_not eq("#{@item_4.created_at}")
      end
    end
  end
end
