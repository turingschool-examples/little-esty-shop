require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it {should have_many :items}

  it {should validate_presence_of :name}
end
