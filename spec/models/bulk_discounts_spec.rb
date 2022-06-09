require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'Relationships' do
    it { should belong_to :merchant }

  end
end
