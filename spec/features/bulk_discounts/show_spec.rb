require 'rails_helper'
RSpec.describe 'it shows the desciription of a bulk discounts show page along with its attributes' do
  before :each do  
    visit "/merchants/#{@merchant1.id}/bulk_discounts/#{@bulk_discount1.id}"
  end

  it '' do
  end
end