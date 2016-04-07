require 'open-uri'
require 'json'

class StockTracker
  def initialize
    @all_stocks      = get_all_quote_data["list"]["resources"]
    symbols          = request_symbols
    requested_stocks = find_stocks(symbols)
    print_current_values(requested_stocks)
  end

  def get_all_quote_data
    url = "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"
    JSON.load(open(url))
  end

  def request_symbols
    puts "Please enter the symbols you would like to check, separated by commas:"
    gets.gsub(/\s+/, "").upcase.split(",")
  end

  def find_stocks(symbols)
    @all_stocks.select do |stock| 
      symbol = stock["resource"]["fields"]["symbol"][0..2]
      symbols.include? symbol
    end
  end

  def print_current_values(stocks)
    stocks.each do |stock| 
      stock = stock["resource"]["fields"]
      puts "#{stock['symbol']}: #{stock['price']}"
    end
  end
end

StockTracker.new
