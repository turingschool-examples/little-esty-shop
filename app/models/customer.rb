class Customer < ApplicationRecord
  validates :id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  has_many :invoices
end
