class AddDisbursedAmountToOrders < ActiveRecord::Migration[7.0]
  def change
    add_monetize :orders, :disbursed_amount,
      amount: { null: true, default: nil },
      currency: { present: false }
  end
end
