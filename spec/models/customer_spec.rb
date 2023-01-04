require 'rails_helper'

RSpec.describe Customer do
  describe "Relationships" do
    it {should have_many :invoices} 
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:merchants).through(:invoices)}
    it {should have_many(:items).through(:invoices)}

  end
end