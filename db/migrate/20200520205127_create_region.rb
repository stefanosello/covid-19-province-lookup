class CreateRegion < ActiveRecord::Migration[6.0]
  def change
    create_table(:regions, primary_key: :code, id: :string) do |t|
      t.string :label
      t.string :nation_code

      t.timestamps
    end

    add_foreign_key :regions, :nations, column: :nation_code, primary_key: 'code', on_delete: :cascade
  end
end
