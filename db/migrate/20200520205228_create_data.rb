class CreateData < ActiveRecord::Migration[6.0]
  def change
    create_table :epidemic_data do |t|
      t.datetime :date
      t.integer :total_cases
      t.string :province_code
      t.json :notes
    end

    add_foreign_key :epidemic_data, :provinces, column: :province_code, primary_key: 'code', on_delete: :cascade
    add_index(:epidemic_data, [:date, :province_code], unique: true, name: 'uniq_epidemic_data_index')
  end
end