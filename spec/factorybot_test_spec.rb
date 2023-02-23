require 'rails_helper'

describe 'factorybot' do

  describe 'creating factories' do

    it 'creates one for invoice' do
      x = create(:invoice)
      expect(x).to be_an(Invoice)
    end

    it 'creates one for invoice_items' do
      x = create(:invoice_item)
      expect(x).to be_an(InvoiceItem)
    end

    it 'creates one for items' do
      x = create(:item)
      expect(x).to be_an(Item)
    end

    it 'creates one for merchant' do
      x = create(:merchant)
      expect(x).to be_a(Merchant)
    end

    it 'creates one for transactions' do
      x = create(:transaction)
      expect(x).to be_a(Transaction)
    end
  end
end