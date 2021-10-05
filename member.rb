class Member
  attr_reader :member_name, :acct_balance

  def initialize(name)
    @member_name = name
    puts "member filename: #{filename}"
  end

  def valid?
    File.exist? filename
  end

  def balance
    read_balance
  end

  def filename
    name = member_name.downcase.gsub /\s/, '_'
    "BankTullos_#{name}"
  end

  def withdraw(amount)
    amount = normalize(amount)
    if balance >= amount
      write_balance(acct_balance - amount)
      true
    else
      false
    end
  end

  def read_balance
    bal = 0
    File.open(filename) {|f| bal = f.read }
    @acct_balance = normalize(bal)
  end

  def write_balance(new_balance)
    File.open(filename, 'w') {|f| f.puts new_balance }
    @acct_balance = new_balance
  end

  def normalize(val)
    Float(val)
  end
end
