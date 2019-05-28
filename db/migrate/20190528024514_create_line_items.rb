class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.decimal :price, null: false
      t.integer :qty, null: false
      t.string :description, null: false
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
