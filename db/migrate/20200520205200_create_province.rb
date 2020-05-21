class CreateProvince < ActiveRecord::Migration[6.0]
  def change
    create_table(:provinces, primary_key: :code, id: :string) do |t|
      t.string :label
      t.string :region_code
      t.string :initials
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_foreign_key :provinces, :regions, column: :region_code, primary_key: 'code', on_delete: :cascade
  end
end
