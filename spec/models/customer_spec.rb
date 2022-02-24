require 'rails_helper'

RSpec.describe Customer do
  describe 'relations' do
    it { should have_many :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
end
