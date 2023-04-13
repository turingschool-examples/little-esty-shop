require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:items) }
  it { should have_many(:invoices).through(:items)}
  it { should validate_presence_of(:name)}

  before :each do
    test_data
  end
end
