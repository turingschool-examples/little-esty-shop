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

  describe 'enum' do
    it { define_enum_for(:status) }
  end

  before :each do
    @frank = Customer.create!(first_name: 'Frank', last_name: 'Enstein')

    @invoice1 = @frank.invoices.create!(status: 2)
    @invoice2 = @frank.invoices.create!(status: 2)
    @invoice3 = @frank.invoices.create!(status: 2)

    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)
    @transaction3 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction4 = @invoice2.transactions.create!(result: 0, credit_card_number: 4515551623735607)
    @transaction5 = @invoice3.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction6 = @invoice3.transactions.create!(result: 1, credit_card_number: 4540842003561938)

    @merchant1 = Merchant.create!(name: 'LittleHomeSlice')
    @item1 = @merchant1.items.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, status: 1)
    @item2 = @merchant1.items.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, status: 1)
    @item3 = @merchant1.items.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, status: 1)

    @merchant2 = Merchant.create!(name: 'BreadNButter')
    @item4 = @merchant2.items.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.0, status: 0)
    @item5 = @merchant2.items.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.5, status: 0)
    @item6 = @merchant2.items.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.0, status: 0)
    @item7 = @merchant2.items.create!(name: 'Thing 7', description: 'This is the seventh thing.', unit_price: 11.5, status: 0)
    @item8 = @merchant2.items.create!(name: 'Thing 8', description: 'This is the eighth thing.', unit_price: 18.0, status: 0)
    @item9 = @merchant2.items.create!(name: 'Thing 9', description: 'This is the ninth thing.', unit_price: 17.0, status: 0)
    @item10 = @merchant2.items.create!(name: 'Thing 10', description: 'This is the tenth thing.', unit_price: 21.0, status: 0)

    @invoice_item0 = @item4.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 2, invoice: @invoice1) #96.0  1
    @invoice_item6 = @item9.invoice_items.create!(quantity: 5, unit_price: 17.0, status: 2, invoice: @invoice2) #85.0  1
    @invoice_item3 = @item6.invoice_items.create!(quantity: 7, unit_price: 10.0, status: 2, invoice: @invoice2) #70.0  2
    @invoice_item1 = @item4.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 2, invoice: @invoice2) #48.5  3
    @invoice_item2 = @item5.invoice_items.create!(quantity: 3, unit_price: 15.5, status: 2, invoice: @invoice1) #46.5  4
    @invoice_item4 = @item7.invoice_items.create!(quantity: 4, unit_price: 11.5, status: 2, invoice: @invoice2) #46.0  5

    @invoice_item7 = @item10.invoice_items.create!(quantity: 2, unit_price: 21.0, status: 2, invoice: @invoice3) #42.0
    @invoice_item5 = @item8.invoice_items.create!(quantity: 1, unit_price: 18.0, status: 2, invoice: @invoice3) #18.0
  end

  describe 'class methods' do
    describe '.enable/disable items' do
      it 'can give the correct enabled status' do
        expect(Item.enable_items[0].status).to eq(@item1.status)
        expect(Item.enable_items[0].status).to_not eq(@item4.status)
      end

      it 'can group enabled items' do
        expect(Item.enable_items.first.name).to eq(@item1.name)
        expect(Item.enable_items.second.name).to eq(@item2.name)
        expect(Item.enable_items.third.name).to eq(@item3.name)
        expect(Item.enable_items.last.name).to_not eq(@item1.name)
      end

      it 'can give correct disabled status' do
        expect(Item.disable_items[0].status).to eq(@item4.status)
        expect(Item.disable_items[0].status).to_not eq(@item2.status)
      end

      it 'can group disabled items' do
        expect(Item.disable_items.first.name).to eq(@item4.name)
        expect(Item.disable_items.third.name).to eq(@item6.name)
        expect(Item.disable_items.fifth.name).to eq(@item8.name)
        expect(Item.disable_items.last.name).to eq(@item10.name)
        expect(Item.disable_items.last.name).to_not eq(@item9.name)
      end
    end

    describe '.total revenue' do
      it 'can list top 5 most popular items ranked by total revenue generated' do
        expect(Item.top_popular_items.first.name).to eq(@item4.name)
        expect(Item.top_popular_items.first.name).to_not eq(@item7.name)
      end
    end

    describe '#not_shipped' do
      it 'can list items ready for shipping by merchant' do
        @invoice_item99 = @item1.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 1, invoice: @invoice2)
        @invoice_item100 = @item2.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 1, invoice: @invoice2)
        @invoice_item101 = @item2.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 1, invoice: @invoice2)

        expect(Item.not_shipped(@merchant1.id).first.name).to eq(@item1.name)
        expect(Item.not_shipped(@merchant1.id).second.name).to eq(@item1.name)
        expect(Item.not_shipped(@merchant1.id).third.name).to eq(@item2.name)
        expect(Item.not_shipped(@merchant1.id).fourth.name).to eq(@item2.name)
        expect(Item.not_shipped(@merchant1.id).fifth.name).to eq(@item2.name)
      end
    end
  end

  describe 'instance methods' do
    describe '#total revenue top date' do
      it 'can give the date with the most sales for each of the most popluar items' do
        expect(@item4.items_top_selling_days).to eq("#{@item4.created_at.strftime("%m/%d/%Y")}")
        expect(@item4.items_top_selling_days).to_not eq("#{@item4.created_at}")
      end
    end
  end
end
