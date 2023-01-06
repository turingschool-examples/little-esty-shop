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

    @transaction1 = Transaction.create!(credit_card_number: '123456789', credit_card_expiration_date: '05/07', invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '987654321', credit_card_expiration_date: '04/07', invoice_id: @invoice2.id)
    @transaction3 = Transaction.create!(credit_card_number: '543219876', credit_card_expiration_date: '03/07', invoice_id: @invoice3.id)

    @transaction4 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: @invoice4.id)

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

  describe 'story 2' do
#     As a merchant,
# When I visit my merchant dashboard
# Then I see link to my merchant items index (/merchants/merchant_id/items)
# And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
    it "has a link to the merchant items index" do
      visit "merchants/#{@merchant1.id}/dashboards"
      
      expect(page).to have_link("#{@merchant1.name} items")
    end
    
    it "has a link to the merchant invoices index" do
      visit "merchants/#{@merchant1.id}/dashboards"
      
      expect(page).to have_link("#{@merchant1.name} invoices")
      
    end
  end
  describe 'story 3' do
    it "When I visit my merchant dashboard
    Then I see the names of the top 5 customers
    who have conducted the largest number of successful transactions with my merchant
    And next to each customer name I see the number of successful transactions they have
    conducted with my merchant" do
    
    customer3 = Customer.create!(first_name: 'Third', last_name: 'Guy')
    customer4 = Customer.create!(first_name: 'Fourth', last_name: 'Guy')
    customer5 = Customer.create!(first_name: 'Fifth', last_name: 'Guy')
    customer6 = Customer.create!(first_name: 'Sixth', last_name: 'Guy')

    item5 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice5 = Invoice.create!(status: 1, customer_id: @customer1.id)
    transaction5 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice5.id)
    ii5 = InvoiceItem.create!(quantity: 5, unit_price: item5.unit_price, item_id: item5.id, invoice_id: invoice5.id)

    item6 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice6 = Invoice.create!(status: 1, customer_id: @customer2.id)
    transaction6 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice6.id)
    ii6 = InvoiceItem.create!(quantity: 5, unit_price: item6.unit_price, item_id: item6.id, invoice_id: invoice6.id)

    item7 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice7 = Invoice.create!(status: 1, customer_id: @customer2.id)
    transaction7 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice7.id)
    ii7 = InvoiceItem.create!(quantity: 5, unit_price: item7.unit_price, item_id: item7.id, invoice_id: invoice7.id)

    item8 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice8 = Invoice.create!(status: 1, customer_id: @customer2.id)
    transaction8 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice8.id)
    ii8 = InvoiceItem.create!(quantity: 5, unit_price: item8.unit_price, item_id: item8.id, invoice_id: invoice8.id)    
    

    
    item9 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice9 = Invoice.create!(status: 1, customer_id: customer3.id)
    transaction9 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice9.id)
    ii9 = InvoiceItem.create!(quantity: 5, unit_price: item9.unit_price, item_id: item9.id, invoice_id: invoice9.id)

    item10 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice10 = Invoice.create!(status: 1, customer_id: customer3.id)
    transaction10 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice10.id)
    ii10 = InvoiceItem.create!(quantity: 5, unit_price: item10.unit_price, item_id: item10.id, invoice_id: invoice10.id)
    
    item11 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice11 = Invoice.create!(status: 1, customer_id: customer3.id)
    transaction11 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice11.id)
    ii11 = InvoiceItem.create!(quantity: 5, unit_price: item11.unit_price, item_id: item11.id, invoice_id: invoice11.id)
    


    item12 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice12 = Invoice.create!(status: 1, customer_id: customer4.id)
    transaction12 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice12.id)
    ii12 = InvoiceItem.create!(quantity: 5, unit_price: item12.unit_price, item_id: item12.id, invoice_id: invoice12.id)

    item13 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice13 = Invoice.create!(status: 1, customer_id: customer4.id)
    transaction13 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice13.id)
    ii13 = InvoiceItem.create!(quantity: 5, unit_price: item13.unit_price, item_id: item13.id, invoice_id: invoice13.id)
    
    item14 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice14 = Invoice.create!(status: 1, customer_id: customer4.id)
    transaction14 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice14.id)
    ii14 = InvoiceItem.create!(quantity: 5, unit_price: item14.unit_price, item_id: item14.id, invoice_id: invoice14.id)
    
    item15 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice15 = Invoice.create!(status: 1, customer_id: @customer2.id)
    transaction15 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice15.id)
    ii15 = InvoiceItem.create!(quantity: 5, unit_price: item15.unit_price, item_id: item15.id, invoice_id: invoice15.id)
    
    item16 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice16 = Invoice.create!(status: 1, customer_id: customer5.id)
    transaction16 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice16.id)
    ii16 = InvoiceItem.create!(quantity: 5, unit_price: item16.unit_price, item_id: item16.id, invoice_id: invoice16.id)

    item17 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice17 = Invoice.create!(status: 1, customer_id: customer5.id)
    transaction17 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice17.id)
    ii17 = InvoiceItem.create!(quantity: 5, unit_price: item17.unit_price, item_id: item17.id, invoice_id: invoice17.id)

    item18 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice18 = Invoice.create!(status: 1, customer_id: customer6.id)
    transaction18 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice18.id)
    ii18 = InvoiceItem.create!(quantity: 5, unit_price: item18.unit_price, item_id: item18.id, invoice_id: invoice18.id)
    

    item19 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice19 = Invoice.create!(status: 1, customer_id: @customer1.id)
    transaction19 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice19.id)
    ii19 = InvoiceItem.create!(quantity: 5, unit_price: item19.unit_price, item_id: item19.id, invoice_id: invoice19.id)


    item20 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
    invoice20 = Invoice.create!(status: 1, customer_id: customer3.id)
    transaction20 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice20.id)
    ii20 = InvoiceItem.create!(quantity: 5, unit_price: item20.unit_price, item_id: item20.id, invoice_id: invoice20.id)

    visit "merchants/#{@merchant1.id}/dashboards"
    expect(page).to have_content("Name: Kyle Ledin, Transactions: 25")
    expect(page).to have_content("Name: William Lampke, Transactions: 20")
    expect(page).to have_content("Name: Third Guy, Transactions: 16")
    expect(page).to have_content("Name: Fourth Guy, Transactions: 9")
    expect(page).to have_content("Name: Fifth Guy, Transactions: 4")

    expect(page).to_not have_content("Name: Sixth Guy, Transactions: 1")
    end
  end
end
