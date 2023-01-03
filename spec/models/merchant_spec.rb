require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}    
    it {should validate_presence_of :name}
  end
end