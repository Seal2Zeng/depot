require 'money'
require 'money/bank/google_currency'

bank = Money::Bank::GoogleCurrency.new
puts bank.get_rate(:USD, :USD).to_f