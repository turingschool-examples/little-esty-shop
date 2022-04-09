require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices)}
    
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
