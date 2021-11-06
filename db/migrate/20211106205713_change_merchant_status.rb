class ChangeMerchantStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :merchants, :status, from: 'enabled', to: 'disabled'
  end
end
