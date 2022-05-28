require 'rails_helper'

RSpec.describe Invoice, type: :model do
    describe 'relationships' do 
   it { should belong_to(:customer) }
  end 

  describe 'validations' do 
    it { should validate_presence_of(:status) }
  end
end
