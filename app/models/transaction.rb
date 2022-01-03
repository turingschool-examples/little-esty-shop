class Transaction < ApplicationRecord
  belongs_to :invoice
  enum result: [nil, 'failed', 'success']
end
