class Brokerage
  attr_accessor :brokerage_name, :accounts
  def initialize(name)
    @brokerage_name = name
    @accounts = {}
  end

  def to_s
      "#{@brokerage_name} client accounts:\n#{@accounts.keys.join("\n")}"
  end

  def add_account(account)
    @accounts[account.client_name] = account
  end

  def add_account_portfolio(account_name, portfolio)
    @accounts[account_name].portfolios[portfolio.portfolio_name] = portfolio
  end
end