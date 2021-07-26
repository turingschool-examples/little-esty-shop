require 'rails_helper'

RSpec.describe Transaction do
  describe 'associations' do
    it {should belong_to :invoice}
  end
end
