require 'money'
require 'money/bank/google_currency'

module ApplicationHelper
    
    def hidden_div_if(condition, attributes = {}, &block)
        if condition 
            attributes["style"] = "display: none"
        end
        content_tag("div", attributes, &block)
    end
    
    def exchange_price (original_price, from_locale, to_locale)
        locale_currencies = { en: :USD, es: :EUR }
        from_currency = locale_currencies[from_locale]
        to_currency = locale_currencies[to_locale]
        bank = Money::Bank::GoogleCurrency.new
        original_price * bank.get_rate(from_currency, to_currency).to_f
    end
    
end
