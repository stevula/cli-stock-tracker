require 'open-uri'
require 'json'

class StockTracker
  def initialize
    @quotes = get_quote_data["list"]["resources"]
    symbols = get_symbols
    # get_current_values(symbols)
  end

  def get_quote_data
    url = "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"
    JSON.load(open(url))
  end

  def get_symbols
    puts "Please enter the symbols you would like to check, separated by commas:"
    gets.gsub(/\s+/, "").upcase.split(",")
  end

  def get_current_values(symbols)
    values = @quotes.select {|resource| symbols.include? resource["fields"]["symbol"][0..2]}
    p values
  end
end

StockTracker.new
