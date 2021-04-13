class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy

  enum status: {"cancelled" => 1, "in progress" => 0,  "completed" => 2}
  #
  # validates :status, presence: true, inclusion: { in: [:cancelled, :"in progress", :completed] }

  def self.parse_csv(hash)
    hash[:status] = 0 if hash[:status] == "in progress"
    hash[:status] = 1 if hash[:status] == "cancelled"
    hash[:status] = 2 if hash[:status] == "completed"
    create!(hash)
  end
end
