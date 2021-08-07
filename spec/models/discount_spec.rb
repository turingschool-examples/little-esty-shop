require 'rails_helper'

RSpec.describe Discount, type: :model do
  it {should belong_to :merchant}
  it {should have_many(:items).through(:merchant) }
  it {should have_many(:invoice_items).through(:items) }
  it {should have_many(:invoices).through(:invoice_items) }
end
