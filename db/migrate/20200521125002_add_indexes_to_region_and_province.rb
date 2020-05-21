class AddIndexesToRegionAndProvince < ActiveRecord::Migration[6.0]
  def change
    add_index(:provinces, :label)
    add_index(:provinces, :initials, unique: true)
    add_index(:regions, :label, unique: true)
    add_index(:provinces, [:latitude, :longitude])
  end
end
