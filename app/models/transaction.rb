class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result
  belongs_to :invoice

  enum result: {'success': 0, 'failed': 1}
end
