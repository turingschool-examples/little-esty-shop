require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    # it { should have_many(:) }
    # it { should have_many(:).through(:) }
  end

  describe 'enum status' do
    it { should define_enum_for(:status).with_values([:pending, :packaged, :shipped]) }
  end

  describe 'class methods' do
   describe '.locate' do
     it 'locates invoice item with invoice and item ids' do
       expected = InvoiceItem.locate(@invoice1.id, @item1.id)

       expect(expected).to eq(@invoice_item1)
     end
    end

    describe '.total_revenue' do
      it 'calculates total revenue of a collection of invoice items' do
        expected = @invoice1.invoice_items.total_revenue

        expect(expected).to eq(120000)
      end
    end
  end

  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
