class SetDefaultMerchantStatusToDisabled < ActiveRecord::Migration[5.2]
  def change
    change_column_default :merchants, :status, from: 'nil', to: 1
  end
end
