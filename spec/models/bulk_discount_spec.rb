require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do

  describe "validations" do
    it { should validate_presence_of :percentage_discount }
    it { should validate_presence_of :quantity }
    it { should belong_to :merchant }
  end
end
