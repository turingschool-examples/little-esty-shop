class Invoice < ApplicationRecord
  belongs_to :customer
  enum status: ["in progress", "cancelled", "completed"]

  def self.incomplete_invoices
    require 'pry'; binding.pry
  end

end
