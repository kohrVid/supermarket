require_relative '../supermarket.rb'

RSpec.describe Supermarket, type: :model do
  let(:pricing_rule) { FactoryBot.create(:pricing_rule, :line_items) }
  let(:item_a) { FactoryBot.create(:item, :a) }
  let(:item_b) { FactoryBot.create(:item, :b) }
  let(:supermarket) { Supermarket.new }

  context "#init" do
    it "should raise an exception if there are no pricing rules in the database" do
      expect { supermarket.init }.to raise_error(RuntimeError)
    end

    it "should create a new order if there are pricing rules present" do
      pricing_rule

      expect { supermarket.init }.to change{ Order.count }.from(0).to(1)
    end
  end

  context "#show_products" do
    it "should raise an exception if there are no pricing rules in the database" do
      expect { supermarket.show_products }.to raise_error(RuntimeError)
    end

    it "should list all products in the database" do
      item_a
      item_b
      pricing_rule

      expect { supermarket.show_products }.to output(
        "#{{ id: item_a.id, name: item_a.name, price: item_a.price }}\n#{{ id: item_b.id, name: item_b.name, price: item_b.price }}\n"
      ).to_stdout
    end
  end

  context "#scan" do
    it "should raise an exception if there are no pricing rules in the database" do
      expect { supermarket.scan(1) }.to raise_error(RuntimeError)
    end

    context "populated database" do
      let(:order) { Order.first }

      before do
        item_a
        item_b
        pricing_rule
        supermarket.init
      end

      it "should add an item to an order" do
        expect {
          supermarket.scan(item_a.id)
        }.to change{ order.items.count }.from(0).to(1)
      end

      it "should not add items that don't exist" do
        expect {
          supermarket.scan(9999)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should output new items to stdout" do
        expect {
          supermarket.scan(item_a.id)
        }.to output(/Item #{item_a.name} added to order ##{order.id}/).to_stdout
      end
    end
  end

  context "#remove" do
    it "should raise an exception if there are no pricing rules in the database" do
      expect { supermarket.remove(1) }.to raise_error(RuntimeError)
    end

    context "populated database" do
      let(:order) { Order.first }

      before do
        item_a
        item_b
        pricing_rule
        supermarket.init
        supermarket.scan(item_a.id)
        supermarket.scan(item_a.id)
        supermarket.scan(item_b.id)
      end

      it "should remove an item from an order" do
        expect {
          supermarket.remove(item_a.id)
        }.to change{ order.items.count }.from(3).to(2)
      end

      it "should not remove items that don't exist" do
        expect {
          supermarket.remove(9999)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should output removed items to stdout" do
        expect {
          supermarket.remove(item_a.id)
        }.to output(/Item #{item_a.name} removed from order ##{order.id}/).to_stdout
      end
    end
  end

  context "#total" do
    it "should raise an exception if there are no pricing rules in the database" do
      expect { supermarket.total }.to raise_error(RuntimeError)
    end

    context "populated database" do
      let(:order) { Order.first }

      before do
        item_a
        item_b
        pricing_rule
        supermarket.init
      end

      it "should return 0 if no items have been added" do
        expect {
          supermarket.total
        }.to output(/Total payable is £0.00/).to_stdout
      end

      it "should return the order total if items have been added" do
        supermarket.scan(item_a.id)

        expect {
          supermarket.total
        }.to output(/Total payable is £50.00/).to_stdout
      end
    end
  end

  context "#receipt" do
    it "should raise an exception if there are no pricing rules in the database" do
      expect { supermarket.receipt }.to raise_error(RuntimeError)
    end

    context "populated database" do
      let(:order) { Order.first }

      before do
        item_a
        item_b
        pricing_rule
        supermarket.init
      end

      it "should return the names of the items added" do
        supermarket.scan(item_a.id)
        supermarket.scan(item_b.id)

        expect {
          supermarket.receipt
        }.to output(/Order ##{order.id} consists of \[\"A\", \"B\"\]/).to_stdout
      end
    end
  end
end
