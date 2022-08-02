class Transaction < ApplicationRecord
  enum status: {failed: 0, success: 1}

  belongs_to :invoice

  def formatted_date
    created_at.strftime('%m/%d/%y')
  end
end