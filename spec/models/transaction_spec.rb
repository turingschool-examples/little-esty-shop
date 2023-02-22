require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do 
    it { should have_many :invoices}
  end
end
