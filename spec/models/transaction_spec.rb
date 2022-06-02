require 'rails_helper'

RSpec.describe Transaction do
    describe "relationships" do
        it { should belong_to :invoice } 
        it { should have_many(:invoice_items).through(:invoice) } 
    end
    
end