require 'rails_helper'

RSpec.describe Merchant do 
  describe 'relations' do 
    it { should have_many :items }
  end 
end 