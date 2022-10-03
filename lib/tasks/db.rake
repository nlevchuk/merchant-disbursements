def read_data_from_file(filename)
  path = File.join(File.dirname(__FILE__), "../../tmp/#{filename}.json")
  JSON.parse(File.read(path))["RECORDS"]
end

namespace :db do
  desc "Populate database from given dataset JSONs"
  task :populate => :environment do
    merchants = read_data_from_file("merchants")
    Merchant.insert_all(merchants)
    puts "Merchants table has been populated"

    shoppers = read_data_from_file("shoppers")
    Shopper.insert_all(shoppers)
    puts "Shoppers table has been populated"

    orders = read_data_from_file("orders")
    orders.each do |order|
      order["amount"] = order["amount"].to_money
      record = Order.new(order)

      if (record.completed?)
        calculator = OrderDisbursedAmountCalculator.new(record.amount)
        record.disbursed_amount = calculator.calculate_disbursed_amount()
      end

      record.save!
      print "."
    end
    puts "\nOrders table has been populated"
  end
end
