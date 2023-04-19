require 'rails_helper'

RSpec.describe "admin/invoices#show" do
  before :each do
    test_data
  end


  it 'has invoice ID' do
    visit admin_invoices_show
  end
end