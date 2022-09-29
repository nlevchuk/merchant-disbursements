require "test_helper"

describe DisbursementCalculator do
  describe "calculate disbursed amount with fee" do
    describe "when original amount less than 50" do
      before do
        @original_amount = Money.from_cents(4500)
        @calculator = DisbursementCalculator.new(@original_amount)
      end

      it "returns 1% fee" do
        fee = @calculator.calculate_fee()

        assert_equal fee.cents, 45
      end

      it "returns correct disbursed amount" do
        disbursed_amount = @calculator.calculate_disbursed_amount()
        fee = @calculator.calculate_fee()

        assert_equal @original_amount, (fee + disbursed_amount)
      end
    end

    describe "when original amount between 50 and 300" do
      before do
        @original_amount = Money.from_cents(25700)
        @calculator = DisbursementCalculator.new(@original_amount)
      end

      it "returns 0.95% fee" do
        fee = @calculator.calculate_fee()

        assert_equal fee.cents, 244
      end

      it "returns correct disbursed amount" do
        disbursed_amount = @calculator.calculate_disbursed_amount()
        fee = @calculator.calculate_fee()

        assert_equal @original_amount, (fee + disbursed_amount)
      end
    end

    describe "when original amount greater than 300" do
      before do
        @original_amount = Money.from_cents(30100)
        @calculator = DisbursementCalculator.new(@original_amount)
      end

      it "returns 0.85% fee" do
        fee = @calculator.calculate_fee()

        assert_equal fee.cents, 256
      end

      it "returns correct disbursed amount" do
        disbursed_amount = @calculator.calculate_disbursed_amount()
        fee = @calculator.calculate_fee()

        assert_equal @original_amount, (fee + disbursed_amount)
      end
    end
  end
end
