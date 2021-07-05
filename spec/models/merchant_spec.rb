require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:bulk_discounts) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
  end

  describe 'enum' do
    it { should define_enum_for(:status) }
  end

  before :each do
    # enabled
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    @merchant3 = Merchant.create!(name: "Bob", status: 1)
    # disabled
    @merchant4 = Merchant.create!(name: "Johnny", status: 0)
    @merchant5 = Merchant.create!(name: "Carrot Top", status: 0)
    @merchant6 = Merchant.create!(name: "lil boosie", status: 0)

    @item1 = @merchant1.items.create!(name: "socks", description: "soft", unit_price: 3.00, status: 0)
    @item2 = @merchant2.items.create!(name: "watch", description: "bling-blang", unit_price: 400.00, status: 0)
    @item3 = @merchant3.items.create!(name: "skillet", description: "HOT!", unit_price: 45.00, status: 0)
    @item4 = @merchant4.items.create!(name: "3 Pack of Shirts", description: "comfy", unit_price: 18.00, status: 0)
    @item5 = @merchant5.items.create!(name: "shoes", description: "woah, fast boi!", unit_price: 67.00, status: 0)
    @item6 = @merchant6.items.create!(name: "dress", description: "brown-chicken-black-cow", unit_price: 250.00, status: 0)

    @customer1 = Customer.create!(first_name: "Dr.", last_name: "Pepper")

    @invoice1 = @customer1.invoices.create!(status: 2, created_at: "2012-03-21 09:54:09")
    @invoice2 = @customer1.invoices.create!(status: 2, created_at: "2012-04-21 09:54:09")
    @invoice3 = @customer1.invoices.create!(status: 2, created_at: "2012-05-21 09:54:09")

    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)

    @transaction3 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction4 = @invoice2.transactions.create!(result: 0, credit_card_number: 4515551623735607)

    @transaction5 = @invoice3.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction6 = @invoice3.transactions.create!(result: 1, credit_card_number: 4540842003561938)

    @invoice_item1 = @item1.invoice_items.create!(quantity: 6, unit_price: 3.0, status: 2, invoice: @invoice1) # 18
    @invoice_item2 = @item2.invoice_items.create!(quantity: 1, unit_price: 400.0, status: 2, invoice: @invoice1) # 400
    @invoice_item3 = @item3.invoice_items.create!(quantity: 3, unit_price: 45.0, status: 2, invoice: @invoice2) # 135
    @invoice_item4 = @item4.invoice_items.create!(quantity: 5, unit_price: 18.0, status: 2, invoice: @invoice2) # 90
    @invoice_item5 = @item5.invoice_items.create!(quantity: 1, unit_price: 67.0, status: 2, invoice: @invoice3) # 67
    @invoice_item6 = @item6.invoice_items.create!(quantity: 2, unit_price: 250.0, status: 2, invoice: @invoice3) # 500

    @pepper = Customer.create!(first_name: "Dr.", last_name: "Pepper")
    @boosie = Customer.create!(first_name: "Lil", last_name: "Boosie")
    @dizzy = Customer.create!(first_name: "Snoop", last_name: "Dizzy")
    @jordan = Customer.create!(first_name: "Michael", last_name: "Jordan")
    @james = Customer.create!(first_name: "Lebron", last_name: "James")
    @vick = Customer.create!(first_name: "Mike", last_name: "Vick")
  end

  describe 'class methods' do
    describe '.enabled' do
      it "returns merchants with an enable status" do
        expect(Merchant.enabled).to eq([@merchant1, @merchant2, @merchant3])
        expect(Merchant.enabled).to_not eq([@merchant4, @merchant5, @merchant6])
      end
    end

    describe '.disabled' do
      it "returns merchants with an disable status" do
        expect(Merchant.disabled).to eq([@merchant4, @merchant5, @merchant6])
        expect(Merchant.disabled).to_not eq([@merchant1, @merchant2, @merchant3])
      end
    end

    describe '.new_mechant_id' do
      it "can give a new merchant id" do
        expect(Merchant.new_mechant_id).to eq(Merchant.all.last.id + 1)
        expect(Merchant.new_mechant_id).to_not eq(Merchant.all.last)
      end
    end

    describe '.top_merchants_by_revenue' do
      it "returns merchants by top revenue" do
        expect(Merchant.top_merchants_by_revenue).to eq([@merchant6, @merchant2, @merchant3, @merchant5, @merchant4])
        expect(Merchant.top_merchants_by_revenue).to_not eq([@merchant1, @merchant2, @merchant3, @merchant5, @merchant4])
      end
    end

    describe '.alphabetically' do
      it "returns all merchants alphabetically by name case insensitive" do

        expect(Merchant.alphabetically.first.name).to eq(@merchant3.name)
        expect(Merchant.alphabetically.second.name).to eq(@merchant5.name)
        expect(Merchant.alphabetically.third.name).to eq(@merchant2.name)
        expect(Merchant.alphabetically.fourth.name).to eq(@merchant4.name)
        expect(Merchant.alphabetically.fifth.name).to eq(@merchant6.name)
        expect(Merchant.alphabetically[5].name).to eq(@merchant1.name)
      end
    end
  end

  describe 'instance methods' do
    describe '#merchant_best_day' do
      it "shows top merchants best day" do
        expect(@merchant6.merchant_best_day.strftime("%m/%d/%Y")).to eq("05/21/2012")


        expect(@merchant6.merchant_best_day.strftime("%m/%d/%Y")).to_not eq("04/21/2012")
        expect(@merchant6.merchant_best_day.strftime("%m/%d/%Y")).to_not eq("03/21/2012")
        expect(@merchant6.merchant_best_day).to_not eq(@merchant6.created_at)
      end
    end
  end
end
