require 'rails_helper'

RSpec.describe Transaction do 
  describe 'relationships' do 
    it {should belong_to :invoice}
  end

  # describe 'validations' do 
  #   it {should validate_numericality_of :result}
  #   it {should validate_presence_of :credit_card_number}
  #   # what to do for credit card expiration date? If it is set to nil
  # end
end