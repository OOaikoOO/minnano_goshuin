class DropRatings < ActiveRecord::Migration[6.1]
  def up
    drop_table :ratings
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
