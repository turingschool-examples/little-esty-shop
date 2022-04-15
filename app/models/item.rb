class Item < ApplicationRecord

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: { disabled: 0, enabled: 1 }

  def best_sales_date
    if invoices.count == 0
      return "No Sales Data Available"
    else
      raw = invoices.pluck(:created_at)
      formatted = raw.map!{ |str| Time.parse(str) }
      frequency = Hash.new(0)
      formatted.each { |date| frequency[date.strftime("%B %d, %Y")] += 1}
      best_days = formatted.uniq!.max { |a, b| frequency[a.strftime("%B %d, %Y")] <=> frequency[b.strftime("%B %d, %Y")]}
      best_days.sort[-1].strftime("%B %d, %Y")

      # formatted.each {|date| mode_hash[date] == nil ? model_hash[date] = 1 : mode_hash[date] += 1 }
      # mode = ["date", 0]
      # mode_hash.each_pair do |date, count|
      #   if count > mode[1]

    end
  end

end
