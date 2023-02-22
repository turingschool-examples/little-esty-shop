require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many :items }
end
