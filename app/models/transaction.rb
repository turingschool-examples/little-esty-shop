class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.successful_transactions(invoice_ids)
    where(invoice_id: invoice_ids).where(result: 'success').count
  end
end
