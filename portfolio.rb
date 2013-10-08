class Portfolio
  attr_accessor :portfolio_name, :stocks
  def initialize(portfolio_name)
    @portfolio_name = portfolio_name
    @stocks = {}
  end

  def to_s
    "#{@portfolio_name} portfolio has the following stocks: \n#{@stocks.values.join("\n")}"
  end

  def total_value
    total = 0.00
    #loop through each stock for the portfolio and sum the value & return the total to the calling method
    @stocks.each_value { |stock| total += stock.total_value }
    total
  end

  def buy(stock)
    #check the stock already exists and if it does add the new units to the existing stock
    if @stocks[stock.stock_code]
      @stocks[stock.stock_code].add_units(stock.units)
    else
      #add the new stock to the portfolio
      @stocks[stock.stock_code] = stock
    end
  end

  def sell(stock)
    #check that the stock exists
    if @stocks[stock.stock_code]
      #remove the sold units from the stock
      sale_value = @stocks[stock.stock_code].sell_units(stock.units)
      #if all the units of a specific stock are sold remove the stock from the portfolio
      if @stocks[stock.stock_code].total_value == 0
        @stocks.delete(stock.stock_code)
      end
      sale_value
    else
        #if the stock doesn't exist then you can't sell it
        puts "This stock does not exist in the #{@portfolio_name} portfolio."
        sale_value = 0
    end
  end

end