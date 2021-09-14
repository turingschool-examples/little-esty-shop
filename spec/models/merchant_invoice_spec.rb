require 'rails_helper'

RSpec.describe MerchantInvoice, type: :model do
  it { should belong_to :merchant }
  it { should belong_to :invoice }
end
