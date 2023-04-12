require 'rails_helper'

RSpec.describe Transaction do
  describe 'relationships' do
    it { should belong_to :invoice }
  end

  describe 'enum' do
    it 'defines status as enum' do
      should define_enum_for(:result).
        with_values(failed: 0, success: 1 )
    end
  end
end