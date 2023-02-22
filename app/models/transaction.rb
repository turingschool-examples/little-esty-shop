class Transaction < ApplicationRecord
  belongs_to :invoice
  #OR does one invoice belong to ONE transations?? see invoice.rb

end
