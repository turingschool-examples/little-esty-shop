class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.incomplete_inv
    self.where(status: ['pending', 'packaged'])
  end

end
