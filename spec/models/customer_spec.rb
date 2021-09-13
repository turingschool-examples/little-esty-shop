require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it { should have_many(:invoices) }
  end
end
