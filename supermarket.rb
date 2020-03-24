require 'thor'

class Supermarket < Thor
  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
  end
end

Supermarket.start(ARGV)
