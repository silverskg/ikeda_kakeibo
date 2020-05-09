class CreateIncomeValues < ActiveRecord::Migration[5.2]
  def change
    create_table :income_values do |t|
      t.integer :income_id, null: false
      t.date :year_month
      t.integer :value
      t.string :description
      t.timestamps
    end
  end
end
