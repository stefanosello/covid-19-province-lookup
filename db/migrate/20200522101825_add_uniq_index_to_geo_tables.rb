class AddUniqIndexToGeoTables < ActiveRecord::Migration[6.0]
  def change
    add_index(:nations, :code, unique: true)
    add_index(:regions, :code, unique: true)
    add_index(:provinces, :code, unique: true)
  end
end
