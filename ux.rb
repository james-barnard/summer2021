TheBank = "Bank Tullos"

class Ux
  def welcome
    %Q[ Welcome to #{TheBank}
    You can trust us with your money!
    ]
  end
  def get_member_name
    welcome
    print 'What is your name? '
    name = gets
    name.chomp if name
  end

  def get_withdrawal
    print 'How much would you like to withdraw? '
    Float(gets || 0)
  end

  def reject_login
    puts "I'm sorry.  You do not have an account at #{TheBank}"
    puts "Did you misspell your login name?"
    close_session
  end

  def fail_withdrawal
    puts "OOPS!!!!  You CANNOT withdraw more than your balance"
    puts "Please login again and try again"
  end

  def close_session
    puts "Thank you for banking with #{TheBank}"
    sleep 2
    print "\n" * 45
  end

  def dispense_cash(amount)
    puts "please take your cash $#{display(amount)}"
  end

  def show_balance(balance)
    puts "Your balance is: #{display(balance)}"
  end

  def display(amount)
    amount.round(2)
  end
end
