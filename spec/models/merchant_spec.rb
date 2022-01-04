require 'rails_helper'
describe Merchant, type: :model do
  it {should have_many :items}
end
