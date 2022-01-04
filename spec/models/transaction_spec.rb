require 'rails_helper'

RSpec.describe Transaction do 
  describe 'relations' do 
    it { should belong_to :invoice }
  end 
end 