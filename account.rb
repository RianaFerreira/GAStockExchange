class Account
  attr_accessor :client_name, :account_balance, :portfolios

  def initialize(name, balance)
    @client_name = name
    @account_balance = balance.to_f
    @portfolios = {}
  end
  def to_s
    #loop through each portfolio linked to the account
    list = ""
    @portfolios.each_value do |portfolio|
      #get the total value of the portfolion
       list += "#{portfolio.portfolio_name} portfolio has the value of $#{portfolio.total_value}\n"
    end
      #get the total value of all the client's portfolios
     list += "Account value $#{total_value}\nAccount balance $#{@account_balance}"
  end
  def buy_stock(stock, portfolio_name)
    #check if the stock price is less than the account balance then deduct the cost of stock
    if stock.total_value.to_f <= @account_balance
      @account_balance -= stock.total_value.to_f
      #add the new stock to the portfolio object and the units to the stock object
      @portfolios[portfolio_name].buy(stock)
    end
  end

  def sell_stock(stock, portfolio_name)
    #add the value of the sold stock to the account balance
    @account_balance += @portfolios[portfolio_name].sell(stock)
  end

  def total_value
    total = 0.00
    #loop through the portfolios for the client and get the total value of all stocks for eaach portfolio
    @portfolios.each_value do |portfolio|
      total += portfolio.total_value
    end
    total
  end
end