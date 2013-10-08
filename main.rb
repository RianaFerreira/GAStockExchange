require 'pry'
require 'YahooFinance'
require_relative 'Brokerage'
require_relative 'Account'
require_relative 'Portfolio'
require_relative 'Stock'
#create a new instance of the brokerage to access all the nested account, portfolio and stock objects
$brokerage = Brokerage.new("GA Brokerage")

#generic method to get user input
def get_input(prompt)
  #get a message to display to the user and return the entered value
  print prompt
  gets.chomp
end

def build_menu
response = 0
  while response != 8
    puts "GA Stock Exchange\n
          (1) Create client account
          (2) Create account portfolio
          (3) Buy stock for portfolio
          (4) Sell stock for portfolio
          (5) List all portfolios for a client
          (6) List all stocks for a portfolio
          (7) List all clients for a brokerage
          (8) Close program"
    response = get_input("Select a menu option: ").to_i
    case response
    when 1
      create_client_account
    when 2
      create_account_portfolio
    when 3
      buy_portfolio_stock
    when 4
      sell_portfolio_stock
    when 5
      list_client_portfolios
    when 6
      list_portfolio_stocks
    when 7
      list_all_clients
    else
      "Invalid menu option selected."
    end
  end
end

def create_client_account
  account = Account.new(get_input("Client Name: "), get_input("Balance: ").to_f)
  $brokerage.add_account(account)
  puts $brokerage
end

def create_account_portfolio
  puts $brokerage
  account_name = get_input("Account Name: ")
  portfolio = Portfolio.new(get_input("Portfolio Name: "))
  $brokerage.add_account_portfolio(account_name,portfolio)
end

def buy_portfolio_stock
  puts $brokerage
  account = $brokerage.accounts[get_input("Account Name: ")]
  puts "Portfolios for the account: \n#{account.portfolios.keys.join("\n")}"
  portfolio_name = get_input("Portfolio name: ")
  stock = Stock.new(get_input("Stock Code: "), get_input("Units: "))
  account.buy_stock(stock, portfolio_name)
  puts account.portfolios[portfolio_name]
end

def sell_portfolio_stock
  puts $brokerage
  account = $brokerage.accounts[get_input("Account Name: ")]
  portfolio_name = get_input("Portfolio Name: ")
  stock = Stock.new(get_input("Stock Code: "), get_input("Units: "))
  account.sell_stock(stock, portfolio_name)
  puts account.portfolios[portfolio_name]
end

def list_client_portfolios
  puts $brokerage
  account = $brokerage.accounts[get_input("Account Name: ")]
  puts account
end

def list_portfolio_stocks
  puts $brokerage
  account = $brokerage.accounts[get_input("Account Name: ")]
  puts "Portfolios for the account: \n#{account.portfolios.keys.join("\n")}"
  portfolio = get_input("Portfolio Name: ")
  puts account.portfolios[portfolio].stocks.keys.join("\n")
end

def list_all_clients
  puts $brokerage
end

build_menu