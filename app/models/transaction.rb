class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: [:success, :failed]

  def self.all_successful_transactions
    where(result: 'success')
  end
end
