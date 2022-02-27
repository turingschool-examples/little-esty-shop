require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :name }
  end

  it 'exists' do
    merchant = create(:merchant)
    expect(merchant).to be_a(Merchant)
    expect(merchant).to be_valid
  end

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  it '#ready_items' do
    merchant1 = create(:merchant)

    item1 = create(:item, merchant: merchant1)

    ii1 = create(:invoice_item, status: "shipped", item: item1)
    ii2 = create(:invoice_item, status: "packaged", item: item1)
    ii3 = create(:invoice_item, status: "pending", item: item1)

    expect(merchant1.ready_items).to eq([ii2, ii3])
  end

  it "lists only enabled merchants" do
    @merchant1 = Merchant.create!(name: "The Tornado", status: 1)
    @merchant3 = Merchant.create!(name: "The Mornado", status: 1)
    @merchant2 = Merchant.create!(name: "The Vornado", status: 0)
    @merchant4 = Merchant.create!(name: "The Lornado", status: 0)
    expect(Merchant.enabled).to eq([@merchant1, @merchant3])
    expect(Merchant.enabled).to_not eq([@merchant2, @merchant4])
  end

  it "lists only disabled merchants" do
    @merchant1 = Merchant.create!(name: "The Tornado", status: 1)
    @merchant3 = Merchant.create!(name: "The Mornado", status: 1)
    @merchant2 = Merchant.create!(name: "The Vornado", status: 0)
    @merchant4 = Merchant.create!(name: "The Lornado", status: 0)
    expect(Merchant.disabled).to_not eq([@merchant1, @merchant3])
    expect(Merchant.disabled).to eq([@merchant2, @merchant4])
  end

  it "tests top five"do
    merchant1 = Merchant.create!(name: "The Tornado")
    item1 = merchant1.items.create!(name: "SmartPants", description: "IQ + 20", unit_price: 120)
    item2 = merchant1.items.create!(name: "FunPants", description: "Cha + 20", unit_price: 2000)
    item3 = merchant1.items.create!(name: "FitPants", description: "Con + 20", unit_price: 150)
    item4 = merchant1.items.create!(name: "VeinyShorts", description: "Str + 20", unit_price: 1400)
    item5 = merchant1.items.create!(name: "SpringSocks", description: "DX + 20", unit_price: 375)
    item6 = merchant1.items.create!(name: "UnderRoos", description: "SNUG!", unit_price: 25)
    item7 = merchant1.items.create!(name: "SunStoppers", description: "Eclipse ready!", unit_price: 50)
    customer1 = Customer.create!(first_name: "Marky", last_name: "Mark" )
    customer2 = Customer.create!(first_name: "Larky", last_name: "Lark" )
    customer3 = Customer.create!(first_name: "Sparky", last_name: "Spark" )
    customer4 = Customer.create!(first_name: "Farky", last_name: "Fark" )
    invoice1 = customer1.invoices.create!(status: 0)
    invoice2 = customer2.invoices.create!(status: 0)
    invoice3 = customer3.invoices.create!(status: 0)
    invoice4 = customer4.invoices.create!(status: 0)
    invoice5 = customer4.invoices.create!(status: 0)

    invoice_item2 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 2000, status: 0)
    invoice_item4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item1.id, quantity: 2, unit_price: 120, status: 1)
    invoice_item7 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item7.id, quantity: 15, unit_price: 50, status: 2)
    invoice_item3 = InvoiceItem.create!(invoice_id: invoice5.id, item_id: item3.id, quantity: 5, unit_price: 125, status: 0)
    invoice_item1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 2, unit_price: 125, status: 0)
    invoice_item6 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item6.id, quantity: 20, unit_price: 25, status: 2)
    invoice_item5 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item2.id, quantity: 2, unit_price: 2000, status: 1)
    invoice_item8 = InvoiceItem.create!(invoice_id: invoice5.id, item_id: item2.id, quantity: 1, unit_price: 2000, status: 1)
    invoice_item9 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item4.id, quantity: 3, unit_price: 1400, status: 2)

    transaction1 = Transaction.create!(credit_card_number: 123456, result: 1, invoice_id: invoice1.id)
    transaction2 = Transaction.create!(credit_card_number: 123456, result: 1, invoice_id: invoice2.id)
    transaction3 = Transaction.create!(credit_card_number: 123456, result: 1, invoice_id: invoice3.id)
    transaction4 = Transaction.create!(credit_card_number: 123456, result: 1, invoice_id: invoice4.id)
    transaction5 = Transaction.create!(credit_card_number: 123456, result: 1, invoice_id: invoice5.id)

    expect(merchant1.top_five).to eq([item2, item1, item4, item7, item3])
  end
end
