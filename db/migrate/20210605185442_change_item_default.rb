class ChangeItemDefault < ActiveRecord::Migration[5.2]
  def change
    execute("ALTER TABLE items ALTER COLUMN enabled SET DEFAULT 0;")
  end
end
