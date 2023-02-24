require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do 
    it { should belong_to :invoice}
    it { should define_enum_for(:result).with_values(["success", "failed"]) }
  end
end
