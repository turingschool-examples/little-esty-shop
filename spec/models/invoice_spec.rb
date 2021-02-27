require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items ).through(:invoice_items)}
  end

  describe 'class methods' do
    describe '::incomplete' do
      it 'displays invoices with status of cancelled or in progress' do
        invoice_1 = create(:invoice, status: 0)
        invoice_2 = create(:invoice, status: 0)
        invoice_3 = create(:invoice, status: 2)
        invoice_4 = create(:invoice, status: 1)
        invoice_5 = create(:invoice, status: 1)
        invoice_6 = create(:invoice, status: 1)
        invoice_7 = create(:invoice, status: 2)

        expect((Invoice.incomplete).count).to eq(4)
      end
    end

    describe '::oldest_to_newest' do
      it 'sorts incomplete invoices from oldest to newest by create date' do
        invoice_1 = create(:invoice, status: 0, created_at: Time.parse("2015-10-31"))
        invoice_2 = create(:invoice, status: 0, created_at: Time.parse("2010-09-20"))
        invoice_3 = create(:invoice, status: 2, created_at: Time.parse("2019-03-25"))
        invoice_7 = create(:invoice, status: 2, created_at: Time.parse("2000-11-18"))

        expect(Invoice.oldest_to_newest.first).to eq(invoice_7)
        expect(Invoice.oldest_to_newest.last).to eq(invoice_3)
      end
    end
  end

  describe 'instance methods' do
    describe '#date_created' do
      it "formats created_at value to 'Monday, July 18, 2019'" do
        invoice_1 = create(:invoice, status: 0)
        invoice_2 = create(:invoice, status: 0)
        invoice_3 = create(:invoice, status: 2)
        invoice_7 = create(:invoice, status: 2)

        expect(invoice_1.date_created).to eq(invoice_1.created_at.strftime("%A, %B %e, %Y"))
      end
    end
  end
end
