class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :shopper

  monetize :amount_cents
  monetize :disbursed_amount_cents, allow_nil: true

  def completed?
    completed_at != nil
  end
end
