require 'rails_helper'

RSpec.describe Customer do 
  describe 'relations' do 
    it { should have_many :invoices }
  end 
end 