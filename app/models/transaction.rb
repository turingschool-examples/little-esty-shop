class Transaction < ApplicationRecord
  validates_presence_of :result
  validates_presence_of :invoice_id
  belongs_to :invoice

  enum result:{
    success: 0,
    failed: 1
  }

  scope :transaction_successful?, -> { where(result: 0) }
end
