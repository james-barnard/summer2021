require './ux'
require './member'
require 'pry-byebug'

class AutomaticTellerMachine
  def self.run
    ux = Ux.new
    while true do
      member_name = ux.get_member_name
      break unless member_name

      member = Member.new(member_name)

      if member.valid?
        ux.show_balance(member.balance)
        withdrawal = ux.get_withdrawal
        if member.withdraw(withdrawal)
          ux.dispense_cash(withdrawal)
        else
          ux.fail_withdrawal
        end
      else
        ux.reject_login
      end

      ux.show_balance(member.balance)
      ux.close_session
    end
  end
end
