class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :merchant, null: false, foreign_key: true
      t.references :shopper, null: false, foreign_key: true
      t.monetize :amount # it is null: false by default
      t.datetime :created_at, null: false
      t.datetime :completed_at
    end
  end
end
