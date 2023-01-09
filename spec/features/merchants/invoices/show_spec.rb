# When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
# Then I see information related to that invoice including:

# Invoice id
# Invoice status
# Invoice created_at date in the format "Monday, July 18, 2019"
# Customer first and last name

require 'rails_helper'

RSpec.describe 'Merchant invoice show page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
    @merchant2 = Merchant.create!(name: 'Jays Foot Made Jewlery')

    @item1 = @merchant1.items.create!(name: 'Chips', description: 'Ring', unit_price: 20)
    @item2 = @merchant1.items.create!(name: 'darrel', description: 'Bracelet', unit_price: 40)
    @item3 = @merchant1.items.create!(name: 'don', description: 'Necklace', unit_price: 30)
    @item4 = @merchant2.items.create!(name: 'fake', description: 'Toe Ring', unit_price: 30)

    @customer1 = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
    @customer2 = Customer.create!(first_name: 'William', last_name: 'Lampke')

    @invoice1 = @customer1.invoices.create!(status: 1)
    @invoice2 = @customer1.invoices.create!(status: 1)
    @invoice3 = @customer1.invoices.create!(status: 1)
    @invoice4 = @customer2.invoices.create!(status: 1)

    @transaction1 = @invoice1.transactions.create!(credit_card_number: '123456789', credit_card_expiration_date: '05/07')
    @transaction2 = @invoice2.transactions.create!(credit_card_number: '987654321', credit_card_expiration_date: '04/07')
    @transaction3 = @invoice3.transactions.create!(credit_card_number: '543219876', credit_card_expiration_date: '03/07')
    @transaction4 = @invoice4.transactions.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07')

    @ii1 = InvoiceItem.create!(quantity: 5, unit_price: @item1.unit_price, item_id: @item1.id, invoice_id: @invoice1.id)
    @ii2 = InvoiceItem.create!(quantity: 5, unit_price: @item2.unit_price, item_id: @item2.id, invoice_id: @invoice2.id)
    @ii3 = InvoiceItem.create!(quantity: 5, unit_price: @item3.unit_price, item_id: @item3.id, invoice_id: @invoice3.id)
    @ii4 = InvoiceItem.create!(quantity: 5, unit_price: @item4.unit_price, item_id: @item4.id, invoice_id: @invoice4.id)
  end
  it 'lists invoices attributes' do
    visit merchant_invoice_path(@merchant1, @invoice1)
    
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
    expect(page).to have_content(@invoice1.created_at.strftime("%A, %B%e, %Y"))
    expect(page).to have_content(@customer1.first_name)
    expect(page).to have_content(@customer1.last_name)
  end
  describe "total revenue (userstory 17)" do
    it "As a merchant
    When I visit my merchant invoice show page
    Then I see the total revenue that will be generated from all of my items on the invoice" do

    item5 = @merchant1.items.create!(name: 'food1', description: "a", unit_price: 10)
    item6 = @merchant1.items.create!(name: 'food2', description: "b", unit_price: 5)

    ii5 = InvoiceItem.create!(quantity: 5, unit_price: 10, item_id: item5.id, invoice_id: @invoice1.id)
    ii6 = InvoiceItem.create!(quantity: 5, unit_price: 5, item_id: item6.id, invoice_id: @invoice1.id)


    visit "merchant/#{@merchant1.id}/invoices/#{@invoice1.id}"
    expect(page).to have_content("Total Revenue: 175")
    
    #calculation
    
    #start from invoice
    #items, invoiceitems
  end
end

end