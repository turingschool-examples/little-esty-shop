require 'rails_helper'

RSpec.describe Invoice, type: :model do

  describe 'relationships' do
    it { should have_many :items }
  end
end