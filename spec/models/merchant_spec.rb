require 'rails_helper'

RSpec.describe Merchant do
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

    @transaction1 = Transaction.create!(credit_card_number: '123456789', credit_card_expiration_date: '05/07',
                                        invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '987654321', credit_card_expiration_date: '04/07',
                                        invoice_id: @invoice2.id)
    @transaction3 = Transaction.create!(credit_card_number: '543219876', credit_card_expiration_date: '03/07',
                                        invoice_id: @invoice3.id)

    @transaction4 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                        invoice_id: @invoice4.id)

    @ii1 = InvoiceItem.create!(quantity: 5, unit_price: @item1.unit_price, item_id: @item1.id, invoice_id: @invoice1.id)
    @ii2 = InvoiceItem.create!(quantity: 5, unit_price: @item2.unit_price, item_id: @item2.id, invoice_id: @invoice2.id)
    @ii3 = InvoiceItem.create!(quantity: 5, unit_price: @item3.unit_price, item_id: @item3.id, invoice_id: @invoice3.id)

    @ii4 = InvoiceItem.create!(quantity: 5, unit_price: @item4.unit_price, item_id: @item4.id, invoice_id: @invoice4.id)
  end

  describe 'Relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe '#top5' do
    it 'returns top 5 customers for a merchant' do
      customer3 = Customer.create!(first_name: 'Third', last_name: 'Guy')
      customer4 = Customer.create!(first_name: 'Fourth', last_name: 'Guy')
      customer5 = Customer.create!(first_name: 'Fifth', last_name: 'Guy')
      customer6 = Customer.create!(first_name: 'Sixth', last_name: 'Guy')

      item5 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice5 = Invoice.create!(status: 1, customer_id: @customer1.id)
      transaction5 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                         invoice_id: invoice5.id)
      ii5 = InvoiceItem.create!(quantity: 5, unit_price: item5.unit_price, item_id: item5.id, invoice_id: invoice5.id)

      item6 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice6 = Invoice.create!(status: 1, customer_id: @customer2.id)
      transaction6 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                         invoice_id: invoice6.id)
      ii6 = InvoiceItem.create!(quantity: 5, unit_price: item6.unit_price, item_id: item6.id, invoice_id: invoice6.id)

      item7 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice7 = Invoice.create!(status: 1, customer_id: @customer2.id)
      transaction7 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                         invoice_id: invoice7.id)
      ii7 = InvoiceItem.create!(quantity: 5, unit_price: item7.unit_price, item_id: item7.id, invoice_id: invoice7.id)

      item8 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice8 = Invoice.create!(status: 1, customer_id: @customer2.id)
      transaction8 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                         invoice_id: invoice8.id)
      ii8 = InvoiceItem.create!(quantity: 5, unit_price: item8.unit_price, item_id: item8.id,
                                invoice_id: invoice8.id)

      item9 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice9 = Invoice.create!(status: 1, customer_id: customer3.id)
      transaction9 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                         invoice_id: invoice9.id)
      ii9 = InvoiceItem.create!(quantity: 5, unit_price: item9.unit_price, item_id: item9.id, invoice_id: invoice9.id)

      item10 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice10 = Invoice.create!(status: 1, customer_id: customer3.id)
      transaction10 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice10.id)
      ii10 = InvoiceItem.create!(quantity: 5, unit_price: item10.unit_price, item_id: item10.id,
                                 invoice_id: invoice10.id)

      item11 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice11 = Invoice.create!(status: 1, customer_id: customer3.id)
      transaction11 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice11.id)
      ii11 = InvoiceItem.create!(quantity: 5, unit_price: item11.unit_price, item_id: item11.id,
                                 invoice_id: invoice11.id)

      item12 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice12 = Invoice.create!(status: 1, customer_id: customer4.id)
      transaction12 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice12.id)
      ii12 = InvoiceItem.create!(quantity: 5, unit_price: item12.unit_price, item_id: item12.id,
                                 invoice_id: invoice12.id)

      item13 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice13 = Invoice.create!(status: 1, customer_id: customer4.id)
      transaction13 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice13.id)
      ii13 = InvoiceItem.create!(quantity: 5, unit_price: item13.unit_price, item_id: item13.id,
                                 invoice_id: invoice13.id)

      item14 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice14 = Invoice.create!(status: 1, customer_id: customer4.id)
      transaction14 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice14.id)
      ii14 = InvoiceItem.create!(quantity: 5, unit_price: item14.unit_price, item_id: item14.id,
                                 invoice_id: invoice14.id)

      item15 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice15 = Invoice.create!(status: 1, customer_id: @customer2.id)
      transaction15 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice15.id)
      ii15 = InvoiceItem.create!(quantity: 5, unit_price: item15.unit_price, item_id: item15.id,
                                 invoice_id: invoice15.id)

      item16 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice16 = Invoice.create!(status: 1, customer_id: customer5.id)
      transaction16 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice16.id)
      ii16 = InvoiceItem.create!(quantity: 5, unit_price: item16.unit_price, item_id: item16.id,
                                 invoice_id: invoice16.id)

      item17 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice17 = Invoice.create!(status: 1, customer_id: customer5.id)
      transaction17 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice17.id)
      ii17 = InvoiceItem.create!(quantity: 5, unit_price: item17.unit_price, item_id: item17.id,
                                 invoice_id: invoice17.id)

      item18 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice18 = Invoice.create!(status: 1, customer_id: customer6.id)
      transaction18 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice18.id)
      ii18 = InvoiceItem.create!(quantity: 5, unit_price: item18.unit_price, item_id: item18.id,
                                 invoice_id: invoice18.id)

      item19 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice19 = Invoice.create!(status: 1, customer_id: @customer1.id)
      transaction19 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice19.id)
      ii19 = InvoiceItem.create!(quantity: 5, unit_price: item19.unit_price, item_id: item19.id,
                                 invoice_id: invoice19.id)

      item20 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice20 = Invoice.create!(status: 1, customer_id: customer3.id)
      transaction20 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice20.id)
      ii20 = InvoiceItem.create!(quantity: 5, unit_price: item20.unit_price, item_id: item20.id,
                                 invoice_id: invoice20.id)

      expect(Merchant.top5(@merchant1.id).first.transactions_count).to eq(25)
      expect(Merchant.top5(@merchant1.id).second.transactions_count).to eq(20)
      expect(Merchant.top5(@merchant1.id).third.transactions_count).to eq(16)
      expect(Merchant.top5(@merchant1.id).fourth.transactions_count).to eq(9)
      expect(Merchant.top5(@merchant1.id).fifth.transactions_count).to eq(4)
    end
  end

  describe 'instance methods' do
    describe '#pending_invoices' do
      it 'returns invoices with status pending for a merchant' do
        merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
        item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: merchant1.id)
        customer = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
        invoice1 = Invoice.create!(status: 1, customer_id: customer.id)
        ii1 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id,
                                  invoice_id: invoice1.id)

        expect(merchant1.pending_invoices).to eq([invoice1])

        invoice2 = Invoice.create!(status: 1, customer_id: customer.id)
        ii2 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id,
                                  invoice_id: invoice2.id)

        expect(merchant1.pending_invoices).to eq([invoice1, invoice2])
      end

      it 'does not return pending invoices for other merchants' do
        merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
        item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: merchant1.id)
        customer = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
        invoice1 = Invoice.create!(status: 1, customer_id: customer.id)
        ii1 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id,
                                  invoice_id: invoice1.id)
        invoice2 = Invoice.create!(status: 1, customer_id: customer.id)
        ii2 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id,
                                  invoice_id: invoice2.id)
        merchant2 = Merchant.create!(name: 'Pizza Man')
        item2 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: merchant2.id)
        invoice3 = Invoice.create!(status: 1, customer_id: customer.id)
        ii3 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item2.id,
                                  invoice_id: invoice3.id)

        expect(merchant1.pending_invoices).to eq([invoice1, invoice2])
        expect(merchant2.pending_invoices).to eq([invoice3])
      end

      it 'does not return invoices with statuses other than pending' do
        merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
        item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: merchant1.id)
        customer = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
        invoice1 = Invoice.create!(status: 0, customer_id: customer.id)
        ii1 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id,
                                  invoice_id: invoice1.id)

        expect(merchant1.pending_invoices).to eq([])
      end

      it 'orders invoices from oldest to newest' do
        merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
        item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: merchant1.id)
        customer = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
        invoice1 = Invoice.create!(status: 1, customer_id: customer.id)
        ii1 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id,
                                  invoice_id: invoice1.id)
        invoice2 = Invoice.create!(status: 1, customer_id: customer.id, created_at: Time.now - 5.days)
        ii2 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id,
                                  invoice_id: invoice2.id)
        invoice3 = Invoice.create!(status: 1, customer_id: customer.id, created_at: Time.now - 15.days)
        ii3 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id,
                                  invoice_id: invoice3.id)

        expect(merchant1.pending_invoices).to eq([invoice3, invoice2, invoice1])
        invoice4 = Invoice.create!(status: 1, customer_id: customer.id, created_at: Time.now - 4.days)
        ii = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id,
                                 invoice_id: invoice4.id)
        expect(merchant1.pending_invoices).to eq([invoice3, invoice2, invoice4, invoice1])
      end
      describe 'top_5_items' do
        it 'returns top 5 most popular items ranked by total revenue generated' do
          # Notes on Revenue Calculation:

          # Only invoices with at least one successful transaction should count towards revenue
          # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
          # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

          merchant = FactoryBot.create(:merchant)
          items = FactoryBot.create_list(:item, 10, merchant_id: merchant.id)
          items.each_with_index do |item, index|
            FactoryBot.create_list(:invoice_item, 2, item_id: item.id, unit_price: (index * 10))
          end
          Invoice.all.each_with_index do |invoice, _index|
            FactoryBot.create(:transaction, invoice_id: invoice.id, result: 1)
          end

          expect(merchant.top_5_items).to eq(items.last(5))
        end
      end
    end
  end
  describe '#enabled and #disabled' do
    it 'pulls up merchants based on status' do
      @merchant1.update(status: 1)
      expect(Merchant.enabled).to eq([@merchant1])
      expect(Merchant.disabled).to eq([@merchant2])
    end
  end
  describe '#top5_merchants' do
    it 'sorts top 5 merchants by total revenue' do
      merchant3 = Merchant.create!(name: 'Third Merchant')
      merchant4 = Merchant.create!(name: 'Fourth Merchant')
      merchant5 = Merchant.create!(name: 'Fifth Merchant')
      merchant6 = Merchant.create!(name: 'Sixth Merchant')

      customer3 = Customer.create!(first_name: 'Third', last_name: 'Guy')
      customer4 = Customer.create!(first_name: 'Fourth', last_name: 'Guy')
      customer5 = Customer.create!(first_name: 'Fifth', last_name: 'Guy')
      customer6 = Customer.create!(first_name: 'Sixth', last_name: 'Guy')

      item5 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice5 = Invoice.create!(status: 1, customer_id: @customer1.id)
      transaction5 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                         invoice_id: invoice5.id)
      ii5 = InvoiceItem.create!(quantity: 5, unit_price: item5.unit_price, item_id: item5.id, invoice_id: invoice5.id)

      item6 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice6 = Invoice.create!(status: 1, customer_id: @customer2.id)
      transaction6 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                         invoice_id: invoice6.id)
      ii6 = InvoiceItem.create!(quantity: 5, unit_price: item6.unit_price, item_id: item6.id, invoice_id: invoice6.id)

      item7 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant1.id)
      invoice7 = Invoice.create!(status: 1, customer_id: @customer1.id)
      transaction7 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                         invoice_id: invoice7.id)
      ii7 = InvoiceItem.create!(quantity: 5, unit_price: item7.unit_price, item_id: item7.id, invoice_id: invoice7.id)

      item8 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant2.id)
      invoice8 = Invoice.create!(status: 1, customer_id: @customer2.id)
      transaction8 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                         invoice_id: invoice8.id)
      ii8 = InvoiceItem.create!(quantity: 5, unit_price: item8.unit_price, item_id: item8.id,
                                invoice_id: invoice8.id)

      item9 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant2.id)
      invoice9 = Invoice.create!(status: 1, customer_id: customer3.id)
      transaction9 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                         invoice_id: invoice9.id)
      ii9 = InvoiceItem.create!(quantity: 5, unit_price: item9.unit_price, item_id: item9.id, invoice_id: invoice9.id)

      item10 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant2.id)
      invoice10 = Invoice.create!(status: 1, customer_id: customer3.id)
      transaction10 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice10.id)
      ii10 = InvoiceItem.create!(quantity: 5, unit_price: item10.unit_price, item_id: item10.id,
                                 invoice_id: invoice10.id)

      item11 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: @merchant2.id)
      invoice11 = Invoice.create!(status: 1, customer_id: customer3.id)
      transaction11 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice11.id)
      ii11 = InvoiceItem.create!(quantity: 5, unit_price: item11.unit_price, item_id: item11.id,
                                 invoice_id: invoice11.id)

      item12 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant3.id)
      invoice12 = Invoice.create!(status: 1, customer_id: customer4.id)
      transaction12 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice12.id)
      ii12 = InvoiceItem.create!(quantity: 5, unit_price: item12.unit_price, item_id: item12.id,
                                 invoice_id: invoice12.id)

      item13 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant3.id)
      invoice13 = Invoice.create!(status: 1, customer_id: customer4.id)
      transaction13 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice13.id)
      ii13 = InvoiceItem.create!(quantity: 5, unit_price: item13.unit_price, item_id: item13.id,
                                 invoice_id: invoice13.id)

      item14 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant3.id)
      invoice14 = Invoice.create!(status: 1, customer_id: customer4.id)
      transaction14 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice14.id)
      ii14 = InvoiceItem.create!(quantity: 5, unit_price: item14.unit_price, item_id: item14.id,
                                 invoice_id: invoice14.id)

      item15 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant3.id)
      invoice15 = Invoice.create!(status: 1, customer_id: @customer2.id)
      transaction15 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice15.id)
      ii15 = InvoiceItem.create!(quantity: 5, unit_price: item15.unit_price, item_id: item15.id,
                                 invoice_id: invoice15.id)

      item16 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant4.id)
      invoice16 = Invoice.create!(status: 1, customer_id: customer5.id)
      transaction16 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice16.id)
      ii16 = InvoiceItem.create!(quantity: 5, unit_price: item16.unit_price, item_id: item16.id,
                                 invoice_id: invoice16.id)

      item17 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant4.id)
      invoice17 = Invoice.create!(status: 1, customer_id: customer5.id)
      transaction17 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice17.id)
      ii17 = InvoiceItem.create!(quantity: 5, unit_price: item17.unit_price, item_id: item17.id,
                                 invoice_id: invoice17.id)

      item18 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant4.id)
      invoice18 = Invoice.create!(status: 1, customer_id: customer6.id)
      transaction18 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice18.id)
      ii18 = InvoiceItem.create!(quantity: 5, unit_price: item18.unit_price, item_id: item18.id,
                                 invoice_id: invoice18.id)

      item19 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant5.id)
      invoice19 = Invoice.create!(status: 1, customer_id: @customer1.id)
      transaction19 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice19.id)
      ii19 = InvoiceItem.create!(quantity: 5, unit_price: item19.unit_price, item_id: item19.id,
                                 invoice_id: invoice19.id)

      item20 = Item.create!(name: 'fak121212e', description: 'T121212ing', unit_price: 30, merchant_id: merchant5.id)
      invoice20 = Invoice.create!(status: 1, customer_id: customer3.id)
      transaction20 = Transaction.create!(credit_card_number: '121987654', credit_card_expiration_date: '02/07',
                                          invoice_id: invoice20.id)
      ii20 = InvoiceItem.create!(quantity: 5, unit_price: item20.unit_price, item_id: item20.id,
                                 invoice_id: invoice20.id)

      expect(Merchant.top5_merchants).to eq([@merchant1, @merchant2, merchant3, merchant4, merchant5])
    end
  end
end
