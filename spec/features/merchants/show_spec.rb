require 'rails_helper'

RSpec.describe 'merchant show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
    @merchant2 = Merchant.create!(name: 'Jays Foot Made Jewlery')

    @item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'darrel', description: 'Bracelet', unit_price: 40, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'don', description: 'Necklace', unit_price: 30, merchant_id: @merchant1.id)

    @item4 = Item.create!(name: 'fake', description: 'Toe Ring', unit_price: 30, merchant_id: @merchant2.id)

    @customer1 = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
    @customer2 = Customer.create!(first_name: 'William', last_name: 'Lampke')

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer1.id)

    @invoice4 = Invoice.create!(status: 1, customer_id: @customer2.id)

    @transaction1 = Transaction.create!(credit_card_number: '123456789', credit_card_exp_date: '05/07', invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '987654321', credit_card_exp_date: '04/07', invoice_id: @invoice2.id)
    @transaction3 = Transaction.create!(credit_card_number: '543219876', credit_card_exp_date: '03/07', invoice_id: @invoice3.id)

    @transaction4 = Transaction.create!(credit_card_number: '121987654', credit_card_exp_date: '02/07', invoice_id: @invoice4.id)

    @ii1 = InvoiceItem.create!(quantity: 5, unit_price: @item1.unit_price, item_id: @item1.id, invoice_id: @invoice1.id)
    @ii2 = InvoiceItem.create!(quantity: 5, unit_price: @item2.unit_price, item_id: @item2.id, invoice_id: @invoice2.id)
    @ii3 = InvoiceItem.create!(quantity: 5, unit_price: @item3.unit_price, item_id: @item3.id, invoice_id: @invoice3.id)

    @ii4 = InvoiceItem.create!(quantity: 5, unit_price: @item4.unit_price, item_id: @item4.id, invoice_id: @invoice4.id)
  end

  describe 'story 1' do
    #   As a merchant,
    # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
    # Then I see the name of my merchant
    it 'shows the name of the merchant' do
      visit "merchants/#{@merchant1.id}/dashboards"

      expect(page).to have_content(@merchant1.name)
    end
  end
end
