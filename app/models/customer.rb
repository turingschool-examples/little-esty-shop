class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  has_many :invoices, dependent: :destroy


  def full_name
    "#{first_name} #{last_name}"
  end
end
