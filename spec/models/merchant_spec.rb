require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before do
    @merchant = Merchant.create!(id: 1, name: 'Willms and Sons')
    @item1 = @merchant.items.create!(id: 1, name: "Item 1", description: "An item", unit_price: 1300)
    @item2 = @merchant.items.create!(id: 2, name: "Item 2", description: "Another item", unit_price: 1200)
    @customer1 = Customer.create!(id: 1, first_name: "John", last_name: "Cena")
    @customer2 = Customer.create!(id: 2, first_name: "Anakin", last_name: "Skywalker")
    @customer3 = Customer.create!(id: 3, first_name: "Luke", last_name: "Jones")
    @customer4 = Customer.create!(id: 4, first_name: "Leah", last_name: "Smith")
    @customer5 = Customer.create!(id: 5, first_name: "Jar Jar", last_name: "Anderson")
    @customer6 = Customer.create!(id: 6, first_name: "Hank", last_name: "Person")
    @invoice1 = @customer1.invoices.create!(id: 1, status: 1)
    @invoice2 = @customer2.invoices.create!(id: 2, status: 1)
    @invoice3 = @customer3.invoices.create!(id: 3, status: 1)
    @invoice4 = @customer4.invoices.create!(id: 4, status: 1)
    @invoice5 = @customer5.invoices.create!(id: 5, status: 1)
    @invoice6 = @customer6.invoices.create!(id: 6, status: 0)
    @invoice7 = @customer1.invoices.create!(id: 7, status: 1)
    @invoice8 = @customer2.invoices.create!(id: 8, status: 1)
    @invoice9 = @customer3.invoices.create!(id: 9, status: 1)
    @invoice10 = @customer4.invoices.create!(id: 10, status: 1)
    @invoice11 = @customer5.invoices.create!(id: 11, status: 2)
    @invoice12 = @customer6.invoices.create!(id: 12, status: 2)
    @invoice13 = @customer1.invoices.create!(id: 13, status: 1)
    @invoice14 = @customer2.invoices.create!(id: 14, status: 1)
    @invoice15 = @customer3.invoices.create!(id: 15, status: 1)
    @invoice_item1 = InvoiceItem.create!(id: 1, item_id: @item1.id, invoice_id: @invoice1.id)
    @invoice_item2 = InvoiceItem.create!(id: 2, item_id: @item1.id, invoice_id: @invoice1.id)
    @invoice_item3 = InvoiceItem.create!(id: 3, item_id: @item1.id, invoice_id: @invoice3.id)
    @invoice_item4 = InvoiceItem.create!(id: 4, item_id: @item1.id, invoice_id: @invoice4.id)
    @invoice_item5 = InvoiceItem.create!(id: 5, item_id: @item1.id, invoice_id: @invoice5.id)
    @invoice_item6 = InvoiceItem.create!(id: 6, item_id: @item1.id, invoice_id: @invoice6.id)
    @invoice_item7 = InvoiceItem.create!(id: 7, item_id: @item1.id, invoice_id: @invoice7.id)
    @invoice_item8 = InvoiceItem.create!(id: 8, item_id: @item2.id, invoice_id: @invoice8.id)
    @invoice_item9 = InvoiceItem.create!(id: 9, item_id: @item2.id, invoice_id: @invoice9.id)
    @invoice_item10 = InvoiceItem.create!(id: 10, item_id: @item2.id, invoice_id: @invoice10.id)
    @invoice_item11 = InvoiceItem.create!(id: 11, item_id: @item2.id, invoice_id: @invoice11.id)
    @invoice_item12 = InvoiceItem.create!(id: 12, item_id: @item2.id, invoice_id: @invoice12.id)
    @invoice_item13 = InvoiceItem.create!(id: 13, item_id: @item2.id, invoice_id: @invoice13.id)
    @invoice_item14 = InvoiceItem.create!(id: 14, item_id: @item2.id, invoice_id: @invoice14.id)
    @invoice_item15 = InvoiceItem.create!(id: 15, item_id: @item2.id, invoice_id: @invoice15.id)
  end

  describe 'relationships' do
    it { should have_many :items }
  end

  describe '#top_customers' do
    it 'can sort top 5 customers for merchant' do
      expect(@merchant.top_customers).to eq([@customer1, @customer2, @customer3, @customer4, @customer5])
    end
  end
end
