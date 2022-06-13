class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def format_created_at(date)
    date.strftime('%A, %B %d, %Y')
  end

  def cents_to_dollars(cents)
    format('%.2f', (cents / 100.0))
  end
end
