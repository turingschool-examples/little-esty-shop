class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  validates_presence_of :name

  enum status: [:enabled, :disabled]

  def enabled!
    update(status: :enabled)
  end
  
  def disabled!
    update(status: :disabled)
  end
end

def update
  @merchant = Merchant.find(params[:id])
  if @merchant.update(merchant_params)
    flash[:success] = "Merchant Updated"
    redirect_to admin_merchant_path(@merchant)
  else
    flash[:notice] = "Merchant Update Failed"
    redirect_to edit_admin_merchant_path(@merchant)
  end
end


