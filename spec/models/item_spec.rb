require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
   it { should validate_presence_of :name }
   it { should validate_presence_of :description }
   it { should validate_presence_of :unit_price }
   it { should validate_presence_of :created_at }
   it { should validate_presence_of :updated_at }
   it { should validate_presence_of :merchant_id }
   it { should define_enum_for(:availability).with_values({ enable: 0, disable: 1}) }
 end

 describe 'relationships' do
   it { should belong_to :merchant}
   it { should have_many :invoice_items }
   it { should have_many(:invoices).through(:invoice_items) }
 end


end
