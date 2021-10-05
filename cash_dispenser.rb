require 'pry-byebug'

Bills = [100, 50, 20, 10, 5, 1]
BillNames = %w[hundreds fifties twenties tens fives ones]
Coins = [50, 25, 10, 5, 1]
CoinNames = %w[half_dollar quarters dimes nickels pennies]

class CashDispenser
  def dispense(amount)
    cash = bills(amount.to_i)
    cash += coins(amount - amount.to_i)

    cash.each do |cnt, item|
      puts "#{cnt} #{item}"
    end
  end

  def bills(dollars)
    count_money(Bills, dollars).zip(BillNames)
  end

  def coins(dollars)
    cents = (dollars * 100).to_i
    puts "coins: #{cents}"
    count_money(Coins, cents).zip(CoinNames)
  end

  def count_money(denominations, amount)
    counts = []
    denominations.reduce(amount) do |rem, bill|
      counts << rem / bill
      rem = rem % bill
    end

    counts
  end
end

cd = CashDispenser.new
amt = 186.96
puts "\n\ndispensing #{amt}"
cd.dispense(amt)
