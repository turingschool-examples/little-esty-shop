class BulkDiscount < ApplicationRecord
  validates_presence_of :discount, :threshold
  belongs_to :merchant

  after_destroy :print_destroy_action

  private

  def print_destroy_action
    puts "Bulk Discount Destroyed!"
  end
end