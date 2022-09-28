namespace :db do
  desc "Populate database from given dataset JSONs"
  task :populate => :environment do
    merchants_path = File.join(File.dirname(__FILE__), "../../tmp/merchants.json")
    merchants = JSON.parse(File.read(merchants_path))["RECORDS"]
    Merchant.insert_all(merchants)
    puts "Merchants table has been populated"

    shoppers_path = File.join(File.dirname(__FILE__), "../../tmp/shoppers.json")
    shoppers = JSON.parse(File.read(shoppers_path))["RECORDS"]
    Shopper.insert_all(shoppers)
    puts "Shoppers table has been populated"

    orders_path = File.join(File.dirname(__FILE__), "../../tmp/orders.json")
    orders = JSON.parse(File.read(orders_path))["RECORDS"]
    orders.each do |order|
      order["amount"] = order["amount"].to_money
      Order.create(order)
      print "."
    end
    puts "\nOrders table has been populated"
  end
end
