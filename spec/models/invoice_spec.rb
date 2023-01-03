require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
  end
  
  describe 'validations' do
    it { should define_enum_for(:status) }
  end
end
