Given(/^i have \$(\d+) in my account$/) do |balance|
  @account = Bank::Account.new("Elvis", balance)
end

When(/^i withdraw the fixed amount of \$(\d+)$/) do |amount|
  @withdraw = -> { @account.withdraw(amount, "0000") }
end

Then(/^the balance of my account should be \$(\d+)$/) do |balance|
  @account.balance("0000").must_equal balance.to_i
end
