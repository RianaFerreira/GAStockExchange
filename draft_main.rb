require 'pry'
require 'YahooFinance'
require_relative 'Brokerage'
require_relative 'Account'
require_relative 'Portfolio'
require_relative 'Stock'

$brokerage = Brokerage.new("GA Brokerage")

def get_input
response = 0
  while response != 8
    puts "GA Stock Exchange\n
          (1) Create client account
          (2) Create portfolio
          (3) Buy stocks
          (4) Sell stocks
          (5) List client portfolios
          (6) List portfolio stocks
          (7) List clients
          (8) Exit program
          "
    print "Select a menu option (1 - 8): "
    response = gets.chomp.to_i
    if response == 8
      puts "Thanks for using the GA Stock Exchange, spend your barrels of cash wisely!"
    else
      determine_selection(response)
    end
  end
end

def determine_selection(response)
  case response
  when 1
    create_client_account
  when 2
    create_portfolio
  when 3
    buy_stocks
  when 4
    sell_stocks
  when 5
    puts "List of client portfolios"
    list_clients_portfolios
  when 6
    puts "List of portfolio stocks"
    list_portfolio_stocks
  when 7
    puts "List of client accounts linked to brokerage"
    list_clients
  else
    puts "Invalid option selected please enter (1 - 8)."
  end
end

def create_client_account
  #get account details
  puts "Add a new Client Account for #{$brokerage.brokerage_name}"
  print "Client Name:\t\t"
  client_name = gets.chomp
  print "Account balance:\t"
  account_balance = gets.chomp.to_f
  #create instance of account class
  new_account = Account.new(client_name, account_balance)
  #link the account to the brokerage
  $brokerage.accounts[new_account.client_name] = new_account
  return new_account
end

def create_portfolio
  #display a list of accounts that can be used to create a new portfolio
  list_clients
  #prompt user to select an account or add a new one if needed
  print "Enter the client name for the new portfolio or 'Add' if the client needs to be setup: "
  account = gets.chomp
  #get the account that object so the new portfolio can be added to it
  if account == "Add"
    account = create_client_account
    puts "#{account.client_name} successfully created, add the new portfolio."
  elsif $brokerage.accounts.key?(account)
    account = $brokerage.accounts[account]
  else
    print "Invalid client name please try again: "
    account = gets.chomp
    account = $brokerage.accounts[account]
  end
  #prompt user for portfolio information
  print "Portfolio Name:\t\t"
  portfolio_name = gets.chomp
  #create instance of portfolio class
  new_portfolio = Portfolio.new(portfolio_name)
  #link the portfolio to client account
  account.portfolios[portfolio_name] = new_portfolio
  puts "#{portfolio_name} portfolio added to #{account.client_name}'s account."
  return account.portfolios
end

def buy_stocks
  #id stock codes to buy
  print "Enter the stock code to determine the current market value: "
  stock_code = gets.chomp
  #call get_market_value method and pass in stock_code
  check_stock_price(stock_code)

  #prompt user to decide to buy or check other stocks
  puts "(1) Buy stocks at current market value\n
        (2) Check other stocks current market value\n
        (3) Exit"
  buy_decision = gets.chomp.to_i

  case buy_decision
  when 1
    #get the account
    puts "Select account for the stock purchase"
    list_clients
    print "Account Name > "
    buying_account = gets.chomp
    buying_account = $brokerage.accounts[buying_account]

    #get the portfolio
    puts "Select portfolio for the new stocks"
    list_client_portfolios
    buying_portfolio = gets.chomp

    #get the number of shares to buy
    can_buy = buying_account.balance / stock_value
    puts "Your account balance allows the purchase of #{can_buy.to_i} #{stock_code} units.\n
          Enter the number of units to buy: "
    units_to_buy = gets.chomp.to_i

    #if units_to_buy <= can_buy
      #get portfolio the stocks should be linked to
      #calculate the purchase cost
      #check account balance & if there still enough funds

    #add the stock to the portfolio
    #update the acount value
    puts "#{stock_code} stocks purchased and added to portfolio #{}"
  when 2
    #id stock codes to buy
    puts "Enter the stock code to determine the current market value"
    stock_code = gets.chomp
  when 3
    get_input
  else
    puts "Invalid selection please enter (1 - 3)."
  end

  get_input
end

def sell_stocks
  #display list of client's portfolio stocks
  list_portfolio_stocks
  #id stocks to sell
  puts "Enter the stock code to determine the current market value"
  stock_code = gets.chomp
  #call get_market_value method and pass in stock_code
  stock = Stock.new
  stock.get_market_value(stock_code)
  #prompt user to decide to sell or quit
  puts "(1) Sell stocks at current market value\n
        (2) Exit"
  sell_decision = gets.chomp.to_i
  case sell_decision
  when 1
    #id portfolio where the stocks are held

    #id number of shares to sell
  when 2
    get_input
  else
    puts "Invalid selection please enter 1 or 2."
  end
end

def check_stock_price(stock_code)
  stock_value = YahooFinance::get_quotes(YahooFinance::StandardQuote,stock_code)[stock_code].lastTrade
  puts "#{stock_code} value is #{stock_value}"
end

def list_clients
  puts $brokerage
end

def list_client_portfolios(client_name)
  puts $brokerage.accounts[client_name]
end

def list_portfolio_stocks
  puts $brokerage.accounts.key("portfolios")
end
get_input