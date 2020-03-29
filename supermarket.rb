require 'active_record'
require 'active_record/base'
require 'colorize'
require 'rake'
require 'thor'
require_relative './lib/models/checkout.rb'

class Supermarket < Thor
  db = YAML.load(File.read("#{Dir.pwd}/db/config.yml"))["development"]
  ActiveRecord::Base.establish_connection(db)
  TMP_DATA = "#{Dir.pwd}/tmp/cli-data.json"

  desc "init", "Initialise the app and with default rows"
  def init
    check_pricing_rules_exist
    pricing_rules = PricingRule.all
    checkout = Checkout.new(pricing_rules)

    puts "Order ##{checkout.order.id} created. Please scan the items that you would like to purchase"
      .colorize(:green)

    update_tmp_data(checkout, pricing_rules)
  end

  desc "show_products", "List all items available in the supermarket"
  def show_products
    check_pricing_rules_exist
    puts Item.all.map{|item| {id: item.id, name: item.name, price: item.price} }
  end

  desc "scan", "Scan an item in the supermarket"
  def scan(item_id)
    check_pricing_rules_exist
    (order, pricing_rules, checkout) = database_variables

    item = Item.find(item_id)
    checkout.scan(item)

    puts "Item #{item.name} added to order ##{checkout.order.id}"
      .colorize(:green)

    update_tmp_data(checkout, pricing_rules)
  end

  desc "total", "Return the basket total"
  def total
    check_pricing_rules_exist
    (order, pricing_rules, checkout) = database_variables

    total = checkout.total
    puts "Total payable is #{total}".colorize(:green)
    update_tmp_data(checkout, pricing_rules)
  end

  desc "receipt", "Show receipt"
  def receipt
    check_pricing_rules_exist
    (order, pricing_rules, checkout) = database_variables

    puts "Order ##{checkout.order.id} consists of #{order.items.map(&:name)}"
      .colorize(:green)
  end

  private

  def check_pricing_rules_exist
    if PricingRule.count < 1
      raise "Please run `rake db:seed` to populate the database first"
        .colorize(:red)
    end
  end

  def update_tmp_data(checkout, pricing_rules)
    File.open(TMP_DATA, "w+") do |f|
      f.write(
        {
          "order": checkout.order,
          "pricing_rules": pricing_rules.map(&:serializable_hash)
        }.to_json
      )
    end
  end

  def database_variables
    order = Order.where(
      JSON.parse(File.read(TMP_DATA))["order"]
        .symbolize_keys.slice(:id, :subtotal, :total, :currency_id)
    ).first

    pricing_rules = PricingRule.all
    checkout = Checkout.new(pricing_rules, order)

    [order, pricing_rules, checkout]
  end
end

Supermarket.start(ARGV)
