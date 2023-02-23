class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  enum status: ["disabled", "enabled" ]

  def self.disabled_status_items(params)
    where(merchant_id: params[:merchant_id]).where(status: "disabled")
  end 

  def self.enabled_status_items(params)
    where(merchant_id: params[:merchant_id]).where(status: "enabled")
  end
end
