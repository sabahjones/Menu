class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :order_num
      t.integer :tip
      t.decimal :total, precision: 6, scale: 2
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
