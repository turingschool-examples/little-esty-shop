require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_many(:invoices) }

  before :each do
    test_data
    require 'pry'; binding.pry
  end
end
