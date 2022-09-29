class OrderDisbursedAmountCalculator
  def initialize(amount)
    @amount = amount
  end

  def calculate_fee
    if (less_than_50?)
      @amount * 0.01 # 1%
    elsif (between_50_and_300?)
      @amount * 0.0095 # 0.95%
    else
      @amount * 0.0085 # 0.85%
    end
  end

  def calculate_disbursed_amount
    fee = calculate_fee
    @amount - fee
  end

  private

  def less_than_50?
    @amount < amount_50
  end

  def between_50_and_300?
    @amount > amount_50 && @amount < amount_300
  end

  def amount_50
    @amount_50 ||= Money.from_amount(50, @amount.currency)
  end

  def amount_300
    @amount_300 ||= Money.from_amount(300, @amount.currency)
  end
end
