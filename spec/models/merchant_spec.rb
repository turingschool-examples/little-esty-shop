require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'Class Methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Johns Tools")
        @merchant_2 = Merchant.create!(name: "Hannas Hammocks")
        @merchant_3 = Merchant.create!(name: "Pretty Plumbing", active_status: :disabled)
        @merchant_4 = Merchant.create!(name: "Jenna's Jewlery")
        @merchant_5 = Merchant.create!(name: "Sassy Soap", active_status: :disabled)
        @merchant_6 = Merchant.create!(name: "Tom's Typewriters", active_status: :disabled)
    end

    it "#active" do
      expect(Merchant.active).to eq([@merchant_1, @merchant_2, @merchant_4])      
    end

    it "#inactive" do
      expect(Merchant.inactive).to eq([@merchant_3, @merchant_5, @merchant_6])      
    end
  end

  describe 'Instance Methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Johns Tools") 
      @merchant_2 = Merchant.create!(name: "Hannas Hammocks") 
      @pretty_plumbing = Merchant.create!(name: "Pretty Plumbing") 
      @sink = @pretty_plumbing.items.create!(name: "Super Sink", description: "Super Sink with Superpowers.") 
      @rug = @pretty_plumbing.items.create!(name: "Hall Rug", description: "It's a rug.") 
      @chair = @pretty_plumbing.items.create!(name: "Great Chair", description: "It's an okay chair.") 
      @lamp = @pretty_plumbing.items.create!(name: "Table Lamp", description: "Lamp for tables.") 
      @toilet = @pretty_plumbing.items.create!(name: "XL-Toilet", description: "Big Toilet.") 

      @customer_1 = Customer.create!(first_name: "Larry", last_name: "Smith")
      @customer_2 = Customer.create!(first_name: "Susan", last_name: "Field")
      @customer_3 = Customer.create!(first_name: "Barry", last_name: "Roger")
      @customer_4 = Customer.create!(first_name: "Mary", last_name: "Flower")
      @customer_5 = Customer.create!(first_name: "Tim", last_name: "Colin")
      @customer_6 = Customer.create!(first_name: "Harry", last_name: "Dodd") 
      @customer_7 = Customer.create!(first_name: "Molly", last_name: "McMann") 
      @customer_8 = Customer.create!(first_name: "Gary", last_name: "Jone") 

      @invoice_1 = @customer_1.invoices.create!(status: :completed, created_at: "08-10-2022")
      @invoice_2 = @customer_2.invoices.create!(status: :completed, created_at: "09-10-2022")
      @invoice_3 = @customer_3.invoices.create!(status: :completed, created_at: "10-08-2022")
      @invoice_4 = @customer_4.invoices.create!(status: :completed, created_at: "10-06-2022")
      @invoice_5 = @customer_5.invoices.create!(status: :completed, created_at: "10-10-2022")
      @invoice_6 = @customer_6.invoices.create!(status: :completed, created_at: "01-07-2022")
      @invoice_7 = @customer_7.invoices.create!(status: :completed, created_at: "10-09-2022")
      @invoice_8 = @customer_8.invoices.create!(status: :completed, created_at: "10-11-2022")

      @invoice_item_1 = InvoiceItem.create!(item_id: "#{@sink.id}", invoice_id: "#{@invoice_1.id}", status: :shipped) 
      @invoice_item_2 = InvoiceItem.create!(item_id: "#{@rug.id}", invoice_id: "#{@invoice_2.id}", status: :shipped) 
      @invoice_item_3 = InvoiceItem.create!(item_id: "#{@chair.id}", invoice_id: "#{@invoice_3.id}", status: :shipped) 
      @invoice_item_4 = InvoiceItem.create!(item_id: "#{@lamp.id}", invoice_id: "#{@invoice_4.id}", status: :pending) 
      @invoice_item_5 = InvoiceItem.create!(item_id: "#{@toilet.id}", invoice_id: "#{@invoice_5.id}", status: :pending) 

      @invoice_item_6 = InvoiceItem.create!(item_id: "#{@sink.id}", invoice_id: "#{@invoice_6.id}", status: :pending) 
      @invoice_item_7 = InvoiceItem.create!(item_id: "#{@rug.id}", invoice_id: "#{@invoice_7.id}", status: :packaged) 
      @invoice_item_8 = InvoiceItem.create!(item_id: "#{@chair.id}", invoice_id: "#{@invoice_8.id}", status: :shipped) 
      @invoice_item_9 = InvoiceItem.create!(item_id: "#{@lamp.id}", invoice_id: "#{@invoice_1.id}", status: :shipped) 
      @invoice_item_10 = InvoiceItem.create!(item_id: "#{@toilet.id}", invoice_id: "#{@invoice_2.id}", status: :shipped) 
    end

    it 'has items_not_shipped method' do
      expect(@pretty_plumbing.items_not_shipped_sorted_by_date).to eq([@invoice_4, @invoice_6, @invoice_7, @invoice_5])
    end

    it '#invoices_distinct_by_merchant' do
      #Test Refactor Needed
      expect(@merchant_2.invoices_distinct_by_merchant).to eq([])
    end
  end
end