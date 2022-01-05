require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end

  # before(:each) do
  #   @merchant_1 = Merchant.create!(name: "Frank")
  #   @item_1 = @merchant_1.items.create!(name: "Item_1", description: "Description_1", unit_price: 16)
  #   @item_2 = @merchant_1.items.create!(name: "Item_2", description: "Description_2", unit_price: 23)
  #   @item_3 = @merchant_1.items.create!(name: "Item_3", description: "Description_3", unit_price: 11)
  #   @item_4 = @merchant_1.items.create!(name: "Item_4", description: "Description_4", unit_price: 312)
  #   @item_5 = @merchant_1.items.create!(name: "Item_5", description: "Description_5", unit_price: 23)
  #   @item_6 = @merchant_1.items.create!(name: "Item_6", description: "Description_6", unit_price: 41)
  #   @item_7 = @merchant_1.items.create!(name: "Item_7", description: "Description_7", unit_price: 153)
  #   @item_8 = @merchant_1.items.create!(name: "Item_8", description: "Description_8", unit_price: 1)
  #   @item_9 = @merchant_1.items.create!(name: "Item_9", description: "Description_9", unit_price: 15)
  #   @item_10 = @merchant_1.items.create!(name: "Item_10", description: "Description_10", unit_price: 87)
  #   @customer_1 = Customer.create!(first_name: "Customer", last_name: "1")
  #   @customer_2 = Customer.create!(first_name: "ACustomer", last_name: "2")
  #   @customer_3 = Customer.create!(first_name: "BCustomer", last_name: "3")
  #   @customer_4 = Customer.create!(first_name: "CCustomer", last_name: "4")
  #   @customer_5 = Customer.create!(first_name: "DCustomer", last_name: "5")
  #   @customer_6 = Customer.create!(first_name: "ECustomer", last_name: "6")
  #   @invoice_1 = @customer_1.invoices.create!
  #   @invoice_2 = @customer_2.invoices.create!
  #   @invoice_3 = @customer_3.invoices.create!
  #   @invoice_4 = @customer_4.invoices.create!
  #   @invoice_5 = @customer_5.invoices.create!
  #   @invoice_6 = @customer_6.invoices.create!
  #   @invoice_1.item_invoices.create!(item_id: @item_1.id)
  #   @invoice_1.item_invoices.create!(item_id: @item_2.id)
  #   @invoice_1.item_invoices.create!(item_id: @item_3.id)
  #   @invoice_1.item_invoices.create!(item_id: @item_4.id)
  #   @invoice_2.item_invoices.create!(item_id: @item_5.id)
  #   @invoice_2.item_invoices.create!(item_id: @item_6.id)
  #   @invoice_2.item_invoices.create!(item_id: @item_7.id)
  #   @invoice_3.item_invoices.create!(item_id: @item_8.id)
  #   @invoice_3.item_invoices.create!(item_id: @item_9.id)
  #   @invoice_3.item_invoices.create!(item_id: @item_10.id)
  #   @invoice_3.item_invoices.create!(item_id: @item_1.id)
  #   @invoice_3.item_invoices.create!(item_id: @item_1.id)
  #   @invoice_4.item_invoices.create!(item_id: @item_2.id)
  #   @invoice_5.item_invoices.create!(item_id: @item_7.id)
  #   @invoice_5.item_invoices.create!(item_id: @item_8.id)
  #   @invoice_5.item_invoices.create!(item_id: @item_9.id)
  #   @invoice_6.item_invoices.create!(item_id: @item_2.id)
  #   @invoice_6.item_invoices.create!(item_id: @item_3.id)
  #   @invoice_6.item_invoices.create!(item_id: @item_4.id)
  #   @invoice_6.item_invoices.create!(item_id: @item_5.id)
  #   @invoice_6.item_invoices.create!(item_id: @item_6.id)
  #   @invoice_6.item_invoices.create!(item_id: @item_7.id)
  # end

  describe 'test' do
    it 'this will test our before each' do
      binding.pry

      expect(Merchant.test).to eq([])
    end
  end
end
