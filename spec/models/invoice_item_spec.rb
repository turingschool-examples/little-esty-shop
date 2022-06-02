require 'rails_helper'

RSpec.describe InvoiceItem do
    describe "relationships" do
        it { should belong_to :item } 
        it { should belong_to :invoice } 
        it { should have_many(:transactions).through(:invoice) } 
    end
    
end