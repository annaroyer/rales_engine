class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :unit_price
      t.references :merchant, foreign_key: true
      t.string :created_at
      t.string :updated_at

      t.timestamps
    end
  end
end
