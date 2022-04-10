class Invoice < ApplicationRecord
  validates :status, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions
  belongs_to :customer

  enum status: { "in_progress" => "0", "completed" => "1", "cancelled" => "2" }

  def self.find_invs_by_merchant(merchant_id)
    joins(:merchants)
    .where("items.merchant_id = #{merchant_id}")
    .distinct
  end
end
