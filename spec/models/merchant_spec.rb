require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :status}
  end

  before(:each) do
  end

  describe 'class methods' do
    describe 'top_five_by_revenue' do
      it 'returns the top five merchants' do
        customer = Customer.create!(first_name: "Very", last_name: "Rich")
        
        merchant3 = Merchant.create!(name: "CCC")
        item3 = merchant3.items.create!(name: "thing", description: "thingy", unit_price: 10)
        invoice3 = customer.invoices.create!(status: 0)
        transaction3 = invoice3.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        invoice_item7 = InvoiceItem.create!(item: item3, invoice: invoice3, quantity: 3, unit_price: 5, status: 2)
        invoice_item8 = InvoiceItem.create!(item: item3, invoice: invoice3, quantity: 3, unit_price: 5, status: 2)
        invoice_item9 = InvoiceItem.create!(item: item3, invoice: invoice3, quantity: 3, unit_price: 5, status: 2)
        
        merchant5 = Merchant.create!(name: "EEE")
        item5 = merchant5.items.create!(name: "thing", description: "thingy", unit_price: 10)
        invoice5 = customer.invoices.create!(status: 0)
        transaction5 = invoice5.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        invoice_item13 = InvoiceItem.create!(item: item5, invoice: invoice5, quantity: 5, unit_price: 5, status: 2)
        invoice_item14 = InvoiceItem.create!(item: item5, invoice: invoice5, quantity: 5, unit_price: 5, status: 2)
        invoice_item15 = InvoiceItem.create!(item: item5, invoice: invoice5, quantity: 5, unit_price: 5, status: 2)
        
        merchant1 = Merchant.create!(name: "AAA")
        item1 = merchant1.items.create!(name: "thing", description: "thingy", unit_price: 10)
        invoice1 = customer.invoices.create!(status: 0)
        transaction1 = invoice1.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 1, unit_price: 5, status: 2)
        invoice_item2 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 1, unit_price: 5, status: 0)
        invoice_item3 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 1, unit_price: 5, status: 1)
        
        merchant6 = Merchant.create!(name: "FFF")
        item6 = merchant6.items.create!(name: "thing", description: "thingy", unit_price: 10)
        invoice6 = customer.invoices.create!(status: 0)
        transaction6 = invoice6.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 0)
        invoice_item16 = InvoiceItem.create!(item: item6, invoice: invoice6, quantity: 6, unit_price: 5, status: 2)
        invoice_item17 = InvoiceItem.create!(item: item6, invoice: invoice6, quantity: 6, unit_price: 5, status: 2)
        invoice_item18 = InvoiceItem.create!(item: item6, invoice: invoice6, quantity: 6, unit_price: 5, status: 2)
        
        merchant7 = Merchant.create!(name: "GGG")
        item7 = merchant7.items.create!(name: "thing", description: "thingy", unit_price: 10)
        invoice7 = customer.invoices.create!(status: 0)
        transaction7 = invoice7.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        invoice_item19 = InvoiceItem.create!(item: item7, invoice: invoice7, quantity: 7, unit_price: 5, status: 2)
        invoice_item20 = InvoiceItem.create!(item: item7, invoice: invoice7, quantity: 7, unit_price: 5, status: 2)
        invoice_item21 = InvoiceItem.create!(item: item7, invoice: invoice7, quantity: 7, unit_price: 5, status: 2)
        
        merchant4 = Merchant.create!(name: "DDD")
        item4 = merchant4.items.create!(name: "thing", description: "thingy", unit_price: 10)
        invoice4 = customer.invoices.create!(status: 0)
        transaction4 = invoice4.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        invoice_item10 = InvoiceItem.create!(item: item4, invoice: invoice4, quantity: 4, unit_price: 5, status: 2)
        invoice_item11 = InvoiceItem.create!(item: item4, invoice: invoice4, quantity: 4, unit_price: 5, status: 2)
        invoice_item12 = InvoiceItem.create!(item: item4, invoice: invoice4, quantity: 4, unit_price: 5, status: 2)
        
        merchant2 = Merchant.create!(name: "BBB")
        item2 = merchant2.items.create!(name: "thing", description: "thingy", unit_price: 10)
        invoice2 = customer.invoices.create!(status: 0)
        transaction2 = invoice2.transactions.create!(credit_card_number: 1111222233334444, credit_card_expiration_date: '', result: 1)
        invoice_item4 = InvoiceItem.create!(item: item2, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)
        invoice_item5 = InvoiceItem.create!(item: item2, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)
        invoice_item6 = InvoiceItem.create!(item: item2, invoice: invoice2, quantity: 2, unit_price: 5, status: 2)

        expect(Merchant.top_five_by_revenue).to eq([merchant7, merchant5, merchant4, merchant3, merchant2])
      end
    end
  end


  describe 'top_five_customers' do
    it "returns the  5 customers with the most sucessful transactions, along with their first and last names" do
      merchant = Merchant.create(name: 'Bob Cella')

      item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
      item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
      item_c = merchant.items.create!(name: "doo-hicky", description: "stuffy stuff", unit_price: 200)

      customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
      customer_b = Customer.create!(first_name: "billy", last_name: "baxter")
      customer_c = Customer.create!(first_name: "charlot", last_name: "carlston")
      customer_d = Customer.create!(first_name: "dany", last_name: "devino")
      customer_e = Customer.create!(first_name: "ellen", last_name: "east")
      customer_f = Customer.create!(first_name: "fredy", last_name: "fox")
      customer_g = Customer.create!(first_name: "george", last_name: "gill")
      customer_h = Customer.create!(first_name: "harry", last_name: "harrison")

      invoice_1a = customer_a.invoices.create!(status: 0)
      invoice_2a = customer_a.invoices.create!(status: 1)
      invoice_3a = customer_a.invoices.create!(status: 2)

      invoice_1b = customer_b.invoices.create!(status: 0)
      invoice_2b = customer_b.invoices.create!(status: 1)
      invoice_3b = customer_b.invoices.create!(status: 2)

      invoice_1c = customer_c.invoices.create!(status: 0)
      invoice_2c = customer_c.invoices.create!(status: 1)
      invoice_3c = customer_c.invoices.create!(status: 2)

      invoice_1d = customer_d.invoices.create!(status: 0)
      invoice_2d = customer_d.invoices.create!(status: 1)
      invoice_3d = customer_d.invoices.create!(status: 2)

      invoice_1e = customer_e.invoices.create!(status: 0)
      invoice_2e = customer_e.invoices.create!(status: 1)
      invoice_3e = customer_e.invoices.create!(status: 2)

      invoice_1f = customer_f.invoices.create!(status: 0)
      invoice_2f = customer_f.invoices.create!(status: 1)
      invoice_3f = customer_f.invoices.create!(status: 2)

      invoice_1g = customer_g.invoices.create!(status: 0)
      invoice_2g = customer_g.invoices.create!(status: 1)
      invoice_3g = customer_g.invoices.create!(status: 2)

      invoice_1h = customer_h.invoices.create!(status: 0)
      invoice_2h = customer_h.invoices.create!(status: 1)
      invoice_3h = customer_h.invoices.create!(status: 2)

      transaction_1	= invoice_1a.transactions.create!(credit_card_number: 4654405418249632,	result: 1, credit_card_expiration_date: nil)
      transaction_2	= invoice_2a.transactions.create!(credit_card_number: 4580251236515201,	result: 1, credit_card_expiration_date: nil)
      transaction_3	= invoice_3a.transactions.create!(credit_card_number: 4354495077693036, result: 1, credit_card_expiration_date: nil)
      transaction_4	= invoice_1b.transactions.create!(credit_card_number: 4515551623735607, result: 1, credit_card_expiration_date: nil)
      transaction_5	= invoice_2b.transactions.create!(credit_card_number: 4844518708741275, result: 1, credit_card_expiration_date: nil)
      transaction_6	= invoice_3b.transactions.create!(credit_card_number: 4203696133194408, result: 1, credit_card_expiration_date: nil)
      transaction_7	= invoice_1c.transactions.create!(credit_card_number: 4801647818676136, result: 1, credit_card_expiration_date: nil)
      transaction_8	= invoice_2c.transactions.create!(credit_card_number: 4540842003561938, result: 0, credit_card_expiration_date: nil)
      transaction_9	= invoice_3c.transactions.create!(credit_card_number: 4140149827486249, result: 1, credit_card_expiration_date: nil)

      transaction_11	= invoice_1d.transactions.create!(credit_card_number: 4654405418249632,	result: 0, credit_card_expiration_date: nil)
      transaction_12	= invoice_2d.transactions.create!(credit_card_number: 4580251236515201,	result: 1, credit_card_expiration_date: nil)
      transaction_13	= invoice_3d.transactions.create!(credit_card_number: 4354495077693036, result: 1, credit_card_expiration_date: nil)
      transaction_14	= invoice_1e.transactions.create!(credit_card_number: 4515551623735607, result: 0, credit_card_expiration_date: nil)
      transaction_15	= invoice_2e.transactions.create!(credit_card_number: 4844518708741275, result: 1, credit_card_expiration_date: nil)
      transaction_16	= invoice_3e.transactions.create!(credit_card_number: 4203696133194408, result: 0, credit_card_expiration_date: nil)
      transaction_17	= invoice_1f.transactions.create!(credit_card_number: 4801647818676136, result: 0, credit_card_expiration_date: nil)
      transaction_18	= invoice_2f.transactions.create!(credit_card_number: 4540842003561938, result: 0, credit_card_expiration_date: nil)
      transaction_19	= invoice_3f.transactions.create!(credit_card_number: 4140149827486249, result: 1, credit_card_expiration_date: nil)

      transaction_21	= invoice_1g.transactions.create!(credit_card_number: 4654405418249632,	result: 1, credit_card_expiration_date: nil)
      transaction_22	= invoice_2g.transactions.create!(credit_card_number: 4580251236515201,	result: 0, credit_card_expiration_date: nil)
      transaction_23	= invoice_3g.transactions.create!(credit_card_number: 4354495077693036, result: 0, credit_card_expiration_date: nil)
      transaction_24	= invoice_1h.transactions.create!(credit_card_number: 4515551623735607, result: 1, credit_card_expiration_date: nil)
      transaction_25	= invoice_2h.transactions.create!(credit_card_number: 4844518708741275, result: 1, credit_card_expiration_date: nil)
      transaction_26	= invoice_3h.transactions.create!(credit_card_number: 4203696133194408, result: 1, credit_card_expiration_date: nil)

      invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_1a.id, item_id: item_a.id)
      invoice_item_2a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_2a.id, item_id: item_b.id)
      invoice_item_3a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_3a.id, item_id: item_c.id)

      invoice_item_1b = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_1b.id, item_id: item_a.id)
      invoice_item_2b = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_2b.id, item_id: item_b.id)
      invoice_item_3b = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_3b.id, item_id: item_c.id)

      invoice_item_1c = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_1c.id, item_id: item_a.id)
      invoice_item_2c = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_2c.id, item_id: item_b.id)
      invoice_item_3c = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_3c.id, item_id: item_c.id)

      invoice_item_1d = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_1d.id, item_id: item_a.id)
      invoice_item_2d = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_2d.id, item_id: item_b.id)
      invoice_item_3d = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_3d.id, item_id: item_c.id)

      invoice_item_1e = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_1e.id, item_id: item_a.id)
      invoice_item_2e = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_2e.id, item_id: item_b.id)
      invoice_item_3e = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_3e.id, item_id: item_c.id)

      invoice_item_1f = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_1f.id, item_id: item_a.id)
      invoice_item_2f = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_2f.id, item_id: item_b.id)
      invoice_item_3f = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_3f.id, item_id: item_c.id)

      invoice_item_1g = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_1g.id, item_id: item_a.id)
      invoice_item_2g = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_2g.id, item_id: item_b.id)
      invoice_item_3g = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_3g.id, item_id: item_c.id)

      invoice_item_1h = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_1h.id, item_id: item_a.id)
      invoice_item_2h = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_2h.id, item_id: item_b.id)
      invoice_item_3h = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 1, invoice_id: invoice_3h.id, item_id: item_c.id)

      expected_result = { [customer_a.id, "albert", "anderston"]=>3,
                          [customer_b.id, "billy", "baxter"]=>3,
                          [customer_h.id, "harry", "harrison"]=>3,
                          [customer_d.id, "dany", "devino"]=>2,
                          [customer_c.id, "charlot", "carlston"]=>2
                        }

      expect(merchant.top_five_customers).to eq(expected_result)
    end
  end
end
