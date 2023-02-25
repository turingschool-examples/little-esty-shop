require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant } 
  it { should have_many :invoice_items }
  it { should have_many :invoices }
  it { should validate_presence_of :name}
  it { should validate_presence_of :description}
  it { should validate_presence_of :unit_price }
end
