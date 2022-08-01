require 'rails_helper'

RSpec.describe Invoice, type: :model do
    describe 'validations' do
     it { should validate_presence_of :status }
     it { should define_enum_for(:status).with_values({in_progress: 0, cancelled: 1, completed: 2}) }
   end
    # it { should define_enum_for(:status).with_values([:completed, :in_progress, :cancelled]) }
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

end
