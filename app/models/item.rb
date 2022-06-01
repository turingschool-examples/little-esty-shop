class Item < ApplicationRecord
  # after_initialize :default_values

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price

  enum status: { 'disabled' => 0, 'enabled' => 1 }
  # enum status: { enabled: true, disabled: false }

  # def default_values
  #   self.status ||= false if self.status.nil?
  # end
end
