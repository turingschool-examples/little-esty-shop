class MerchantsCustomer < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
end
