class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :status, default: 'disable'

      t.timestamps
    end
  end
end
