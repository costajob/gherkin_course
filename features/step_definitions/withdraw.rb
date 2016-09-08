Given(/^i have \$(\d+) in my account$/) do |balance|
  @account = Bank::Account.new("Elvis", balance)
end
