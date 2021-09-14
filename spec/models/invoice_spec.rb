require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it {should validate_presence_of :status}
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transaction}
  end
end
