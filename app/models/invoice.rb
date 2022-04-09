class Invoice < ApplicationRecord
  validates :status, presence: true, numbericality: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  belongs_to :invoice_item
  belongs_to :transaction
  belongs_to :customer

  has_many :items, through: :invoice_items



end
