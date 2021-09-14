require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it {validates_presence_of :name}
    it {validates_presence_of :created_at}
    it {validates_presence_of :updated_at}
    it {validates_presence_of :id}
  end

  describe 'relationships' do
  end
end
