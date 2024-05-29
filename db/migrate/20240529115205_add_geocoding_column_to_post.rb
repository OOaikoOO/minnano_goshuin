class AddGeocodingColumnToPost < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :address, :string, null: false, default: ""
    add_column :posts, :latitude, :float, null: false, default: 0
    add_column :posts, :longitude, :float, null: false, default: 0
  end
end
