class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: { 'success' => true, 'failed' => false }
end
