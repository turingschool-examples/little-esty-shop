require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many :invoice_items }
  it { should have_many(:invoices).through(:invoice_items) }
  it { should have_many(:transactions).through(:invoices) }
end
