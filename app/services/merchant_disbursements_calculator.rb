class MerchantDisbursementsCalculator
  def initialize(date)
    @date = date
  end

  def calculate_for_previous_week
    sunday = end_of_week(@date)
    monday = beginning_of_week(sunday)

    orders = Order
      .select(:merchant_id, :disbursed_amount_cents, :currency)
      .where.not(disbursed_amount_cents: nil)
      .where(completed_at: monday..sunday)

    orders.group_by(&:merchant_id).each do |merchant_id, orders|
      disbursed_amount = orders.reduce(Money.from_cents(0)) do |acc, o|
        acc + o.disbursed_amount
      end

      Disbursement.create(
        merchant_id: merchant_id,
        amount: disbursed_amount,
        week: week_format(monday)
      )
    end
  end

  private

  def end_of_week(date)
    date.yesterday.to_time.end_of_day
  end

  def beginning_of_week(date)
    date.beginning_of_week.beginning_of_day
  end

  def week_format(date)
    date.strftime("%W-%Y") # month-year
  end
end
