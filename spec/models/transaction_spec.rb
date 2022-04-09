require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:credit_card_number)}
    it { should validate_presence_of(:credit_card_expiration_date)}
    it { should define_enum_for(:result).with([
      :success, :failed ])}
  end

  describe 'relationships' do
    it { should belong_to (:invoice) }
  end
end
