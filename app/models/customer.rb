class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices

  def name
    "#{first_name} #{last_name}"
  end
end
