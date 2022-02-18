require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it {should validate_presence_of :customer_id}
  it {should validate_presence_of :status}
  it {should have_many :invoice_items}
  it {should have_many :transactions}
  it {should belong_to :customer}

end
