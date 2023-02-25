require 'rails_helper'

describe 'factorybot' do

  describe 'creating factories' do

    xit 'creates one for invoice' do
      x = create(:invoice)
      expect(x).to be_an(Invoice)
    end

    xit 'creates one for invoice_items' do
      x = create(:invoice_item)
      expect(x).to be_an(InvoiceItem)
    end

    xit 'creates one for items' do
      x = create(:item)
      expect(x).to be_an(Item)
    end

    xit 'creates one for merchant' do
      x = create(:merchant)
      expect(x).to be_a(Merchant)
    end

    xit 'creates one for transactions' do
      x = create(:transaction)
      expect(x).to be_a(Transaction)
    end
  end
end