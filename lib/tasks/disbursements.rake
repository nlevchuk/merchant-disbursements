namespace :disbursements do
  desc "Calculate disbursed amount for merchants and persist them in the database"
  task :calculate => :environment do
    # These dates are first and last mondays from the orders dataset file
    (Date.parse("Jan 08 2018")..Date.parse("Apr 09 2018")).step(7) do |current_date|
      calculator = MerchantDisbursementsCalculator.new(current_date)
      calculator.calculate_for_previous_week()
      print "."
    end
  end
end
