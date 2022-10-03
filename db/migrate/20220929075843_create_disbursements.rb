class CreateDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursements do |t|
      t.references :merchant, null: false, foreign_key: true, index: false
      t.monetize :amount
      t.string :week, null: false
    end

    add_index :disbursements, [:merchant_id, :week],
      unique: true,
      name: "idx_merchant_disbursements_per_week"
  end
end
