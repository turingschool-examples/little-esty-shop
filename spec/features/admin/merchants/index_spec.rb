require 'rails_helper'

RSpec.describe 'admin merchants index' do
  before :each do
    @merchants = FactoryBot.create_list(:merchant, 3)
  end

  describe 'User Story 24 & 25' do
    it 'shows the name of all merchants with links to admin merchant show' do
      visit admin_merchants_path

      expect(page).to have_link(@merchants.first.name, href: admin_merchant_path(@merchants.first))
      expect(page).to have_link(@merchants.second.name, href: admin_merchant_path(@merchants.second))
      expect(page).to have_link(@merchants.third.name, href: admin_merchant_path(@merchants.third))
    end
  end
  describe 'userstory 28' do
    it "When I visit the admin merchants index
    Then I see two sections, one for 'Enabled Merchants' and one for 'Disabled Merchants'
    And I see that each Merchant is listed in the appropriate section" do
      @merchants.first.update(status: 1)
      visit "/admin/merchants"
      within("div#enabled") do
        expect(page).to have_content(@merchants.first.name)

      end
      within("div#disabled") do
        expect(page).to have_content(@merchants.second.name)
        expect(page).to have_content(@merchants.third.name)
      end


    end
  end
  describe 'userstory 30' do 
    it "When I visit the admin merchants index
    Then I see the names of the top 5 merchants by total revenue generated
    And I see that each merchant name links to the admin merchant show page for that merchant
    And I see the total revenue generated next to each merchant name
    Notes on Revenue Calculation:
    Only invoices with at least one successful transaction should count towards revenue
    Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
    Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)" do

    #regular test suite below
    merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
    merchant2 = Merchant.create!(name: 'Jays Foot Made Jewlery')

    item1 = merchant1.items.create!(name: 'Chips', description: 'Ring', unit_price: 20)
    item2 = merchant1.items.create!(name: 'darrel', description: 'Bracelet', unit_price: 40)
    item3 = merchant1.items.create!(name: 'don', description: 'Necklace', unit_price: 30)
    item4 = merchant2.items.create!(name: 'fake', description: 'Toe Ring', unit_price: 30)

    customer1 = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
    customer2 = Customer.create!(first_name: 'William', last_name: 'Lampke')

    invoice1 = customer1.invoices.create!(status: 1)
    invoice2 = customer1.invoices.create!(status: 1)
    invoice3 = customer1.invoices.create!(status: 1)
    invoice4 = customer2.invoices.create!(status: 1)

    transaction1 = invoice1.transactions.create!(credit_card_number: '123456789', credit_card_expiration_date: '05/07')
    transaction2 = invoice2.transactions.create!(credit_card_number: '987654321', credit_card_expiration_date: '04/07')
    transaction3 = invoice3.transactions.create!(credit_card_number: '543219876', credit_card_expiration_date: '03/07')
    transaction4 = invoice4.transactions.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07')

    ii1 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id, invoice_id: invoice1.id)
    ii2 = InvoiceItem.create!(quantity: 5, unit_price: item2.unit_price, item_id: item2.id, invoice_id: invoice2.id)
    ii4 = InvoiceItem.create!(quantity: 5, unit_price: item4.unit_price, item_id: item4.id, invoice_id: invoice4.id)

    #additional test suite for query
    merchant3 = Merchant.create!(name: 'Third Merchant') 
    merchant4 = Merchant.create!(name: 'Fourth Merchant') 
    merchant5 = Merchant.create!(name: 'Fifth Merchant') 
    merchant6 = Merchant.create!(name: 'Sixth Merchant') 

    customer3 = Customer.create!(first_name: 'Third', last_name: 'Guy')
    customer4 = Customer.create!(first_name: 'Fourth', last_name: 'Guy')
    customer5 = Customer.create!(first_name: 'Fifth', last_name: 'Guy')
    customer6 = Customer.create!(first_name: 'Sixth', last_name: 'Guy')

    item5 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant1.id)
    invoice5 = Invoice.create!(status: 1, customer_id: customer1.id)
    transaction5 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice5.id)
    ii5 = InvoiceItem.create!(quantity: 5, unit_price: item5.unit_price, item_id: item5.id, invoice_id: invoice5.id)

    item6 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant1.id)
    invoice6 = Invoice.create!(status: 1, customer_id: customer2.id)
    transaction6 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice6.id)
    ii6 = InvoiceItem.create!(quantity: 5, unit_price: item6.unit_price, item_id: item6.id, invoice_id: invoice6.id)

    item7 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant1.id)
    invoice7 = Invoice.create!(status: 1, customer_id: customer2.id)
    transaction7 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice7.id)
    ii7 = InvoiceItem.create!(quantity: 5, unit_price: item7.unit_price, item_id: item7.id, invoice_id: invoice7.id)

    item8 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant2.id)
    invoice8 = Invoice.create!(status: 1, customer_id: customer2.id)
    transaction8 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice8.id)
    ii8 = InvoiceItem.create!(quantity: 5, unit_price: item8.unit_price, item_id: item8.id, invoice_id: invoice8.id)    
    

    
    item9 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant2.id)
    invoice9 = Invoice.create!(status: 1, customer_id: customer3.id)
    transaction9 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice9.id)
    ii9 = InvoiceItem.create!(quantity: 5, unit_price: item9.unit_price, item_id: item9.id, invoice_id: invoice9.id)

    item10 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant2.id)
    invoice10 = Invoice.create!(status: 1, customer_id: customer3.id)
    transaction10 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice10.id)
    ii10 = InvoiceItem.create!(quantity: 5, unit_price: item10.unit_price, item_id: item10.id, invoice_id: invoice10.id)
    
    item11 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant2.id)
    invoice11 = Invoice.create!(status: 1, customer_id: customer3.id)
    transaction11 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice11.id)
    ii11 = InvoiceItem.create!(quantity: 5, unit_price: item11.unit_price, item_id: item11.id, invoice_id: invoice11.id)
    


    item12 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant3.id)
    invoice12 = Invoice.create!(status: 1, customer_id: customer4.id)
    transaction12 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice12.id)
    ii12 = InvoiceItem.create!(quantity: 5, unit_price: item12.unit_price, item_id: item12.id, invoice_id: invoice12.id)

    item13 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant3.id)
    invoice13 = Invoice.create!(status: 1, customer_id: customer4.id)
    transaction13 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice13.id)
    ii13 = InvoiceItem.create!(quantity: 5, unit_price: item13.unit_price, item_id: item13.id, invoice_id: invoice13.id)
    
    item14 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant3.id)
    invoice14 = Invoice.create!(status: 1, customer_id: customer4.id)
    transaction14 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice14.id)
    ii14 = InvoiceItem.create!(quantity: 5, unit_price: item14.unit_price, item_id: item14.id, invoice_id: invoice14.id)
    
    item15 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant3.id)
    invoice15 = Invoice.create!(status: 1, customer_id: customer2.id)
    transaction15 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice15.id)
    ii15 = InvoiceItem.create!(quantity: 5, unit_price: item15.unit_price, item_id: item15.id, invoice_id: invoice15.id)
    
    item16 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant4.id)
    invoice16 = Invoice.create!(status: 1, customer_id: customer5.id)
    transaction16 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice16.id)
    ii16 = InvoiceItem.create!(quantity: 5, unit_price: item16.unit_price, item_id: item16.id, invoice_id: invoice16.id)

    item17 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant4.id)
    invoice17 = Invoice.create!(status: 1, customer_id: customer5.id)
    transaction17 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice17.id)
    ii17 = InvoiceItem.create!(quantity: 5, unit_price: item17.unit_price, item_id: item17.id, invoice_id: invoice17.id)

    item18 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant4.id)
    invoice18 = Invoice.create!(status: 1, customer_id: customer6.id)
    transaction18 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice18.id)
    ii18 = InvoiceItem.create!(quantity: 5, unit_price: item18.unit_price, item_id: item18.id, invoice_id: invoice18.id)
    

    item19 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant5.id)
    invoice19 = Invoice.create!(status: 1, customer_id: customer1.id)
    transaction19 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice19.id)
    ii19 = InvoiceItem.create!(quantity: 5, unit_price: item19.unit_price, item_id: item19.id, invoice_id: invoice19.id)


    item20 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant5.id)
    invoice20 = Invoice.create!(status: 1, customer_id: customer3.id)
    transaction20 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07', invoice_id: invoice20.id)
    ii20 = InvoiceItem.create!(quantity: 5, unit_price: item20.unit_price, item_id: item20.id, invoice_id: invoice20.id)

    visit "/admin/merchants"
    save_and_open_page
    expect(merchant1.name).to appear_before(merchant2.name)
    expect(merchant2.name).to appear_before(merchant3.name)
    expect(merchant3.name).to appear_before(merchant4.name)
    expect(merchant4.name).to appear_before(merchant5.name)
    end
  end
end