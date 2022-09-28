class BulkDiscount < ApplicationRecord
  validates_presence_of :discount, :threshold
  belongs_to :merchant

  before_validation :check_discount, on: [:create, :update]
  after_destroy :print_destroy_action

  private
  
  def check_discount
    if self.discount >= 1.0
      puts "Discount too darn high! Setting Discount to 5 percent."
      self.discount = 0.05
    end
  end

  def print_destroy_action
    puts "Bulk Discount Destroyed!"
  end
end