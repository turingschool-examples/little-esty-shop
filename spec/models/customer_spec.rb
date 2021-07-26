require 'rails_helper'

RSpec.describe Customer do
  describe 'associations' do
    it {should have_many :invoices}
  end
end
