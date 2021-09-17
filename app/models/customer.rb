class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  has_many :invoices, dependent: :destroy

  def create
  end
end
