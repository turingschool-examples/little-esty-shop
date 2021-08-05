class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def format_date(date)
    date.strftime("%A, %B %d, %Y")
  end

  def self.order_by_name(sort_key, direction = 'ASC')
    order("#{sort_key.to_s} #{direction.to_s}")
  end
  
  def self.order_by_date(sort_key, direction = 'ASC')
    order("#{sort_key.to_s} #{direction.to_s}")
  end

end
