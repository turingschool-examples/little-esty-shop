require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
    describe 'validations' do
        it { should validate_presence_of(:quantity) }
        it { should validate_presence_of(:unit_price) }
        it { should validate_presence_of(:status) }
    end

    describe 'relationships' do
        it { should belong_to(:item) }
        it { should belong_to(:invoice) }
        it { should have_many(:merchants).through(:item) }
        it { should have_many(:transactions).through(:invoice) }
        it { should have_many(:customers).through(:invoice) }
    end

end