require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it {validates_presence_of :status}
  end

  describe 'relationships' do
    it {belongs_to :customer}
  end
end
