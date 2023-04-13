require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should belong_to(:invoice) }

  describe 'enums' do
    it do
      should define_enum_for(:result).
      with_values(["failed", "success"])
    end
  end
end
