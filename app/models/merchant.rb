class Merchant < ApplicationRecord

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true

enum status: [:disable, :enable]

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end

  def self.new_mechant_id
    all.last.id + 1
  end

  def self.top_rev_merchants
    joins(invoies: :invoice_items)

    
    # use where method on invoices.status = completed
  end
end

# Notes on Revenue Calculation:
# - Only invoices with at least one successful transaction should count towards revenue
# - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)


# Then I see the names of the top 5 merchants by total revenue generated
# And I see that each merchant name links to the admin merchant show page for that merchant
# And I see the total revenue generated next to each merchant name
#
