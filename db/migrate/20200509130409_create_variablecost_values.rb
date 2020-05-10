class CreateVariablecostValues < ActiveRecord::Migration[5.2]
  def change
    create_table :variablecost_values do |t|
      t.integer :variablecost_id, null: false
      t.date :year_month
      t.integer :value
      t.string :description
      t.timestamps
    end
  end
end
