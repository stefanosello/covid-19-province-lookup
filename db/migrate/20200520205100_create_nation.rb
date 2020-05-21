class CreateNation < ActiveRecord::Migration[6.0]
  def change
    create_table(:nations, primary_key: :code, id: :string) do |t|
      t.timestamps
    end
  end
end
