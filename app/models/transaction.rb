class Transaction < ApplicationRecord
  validates_presence_of :result
  validates_presence_of :invoice_id
  belongs_to :invoice


end
