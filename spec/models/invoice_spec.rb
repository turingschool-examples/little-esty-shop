require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to(:customer) }
  it { should have_many(:invoice_items) }
  it { should have_many(:items).through(:invoice_items) }
  it { should have_many(:transactions) }

  it { should define_enum_for(:status).with_values('in progress': 0, 'completed': 1, 'cancelled': 2) }
end
