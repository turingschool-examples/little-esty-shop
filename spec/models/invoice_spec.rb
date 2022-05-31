require 'rails_helper'

RSpec.describe Invoice do
    describe "relationships" do
        it { should belong_to :customer } 
    end
end