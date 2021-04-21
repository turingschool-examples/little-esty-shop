class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :invoice_items, through: :invoice

  validates_presence_of :invoice_id, :credit_card_number, :result

  def self.success_count
    where(result: :success).count
  end
end
