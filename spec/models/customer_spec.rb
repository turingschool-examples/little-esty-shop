require 'rails_helper'

RSpec.describe Customer, type: :model do
  it {should have_many(:invoices)}
  it {should have_many(:items).through(:invoices)}
  it {should have_many(:transactions).through(:invoices)}
  it {should have_many(:merchants).through(:items)}


end
