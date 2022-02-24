require 'rails_helper'

RSpec.describe Transaction do
  describe 'relations' do
    it { should belong_to :invoice }
  end

  describe 'validations' do
    it { should validate_presence_of(:invoice_id)}
  end
end
