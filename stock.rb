require 'YahooFinance'
class Stock
  attr_accessor :stock_code, :units
  def initialize(stock_code,units)
    @stock_code = stock_code
    @units = units.to_i
  end

  def to_s
    "#{@stock_code} stock is currently valued at $#{total_value}."
  end

  def total_value
    #lookup the current value of stock and get the total value for all units
    get_market_value * @units
  end

  def get_market_value
    #lookup the current value of stock real-time
    YahooFinance::get_quotes(YahooFinance::StandardQuote,@stock_code)[@stock_code].lastTrade
  end

  def add_units(units)
    #when stock is bought for the portfolio, add those units to the stock
    @units += units
  end

  def sell_units(units)
    #when some of the stock is sold for the portfolio, deduct the number of sold units
    if @units >= units
      @units -= units
      #return value of the units passed into the method that were sold, not the instance varianble @units
      get_market_value * units
    else
      #if all units of stock is sold for the portfolio
      current_value = total_value
      @units = 0
      current_value
    end
  end
end