require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :created_at }
    it { should validate_presence_of :updated_at }
    it { should define_enum_for(:status).with_values([:completed, :in_progress, :cancelled]) }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
  end
end
