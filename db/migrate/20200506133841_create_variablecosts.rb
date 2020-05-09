class CreateVariablecosts < ActiveRecord::Migration[5.2]
  def change
    create_table :variablecosts do |t|
      t.string :name, nul: false
      t.string :description
      t.timestamps
    end
  end
end
