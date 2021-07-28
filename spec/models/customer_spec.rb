require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  describe 'validations' do
    context ':first_name' do
      it { should validate_presence_of(:first_name) }
    end

    context ':last_name' do
      it { should validate_presence_of(:first_name) }
    end
  end
end
