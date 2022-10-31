require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "Relationships" do
    it { should belong_to(:invoice) }
  end
end