When(/^i request \$(\d+)$/) do |amount|
  @account.withdraw(amount, "0000")
end

Then(/^my balance should be \$(\d+)$/) do |balance|
  @account.balance("0000").must_equal balance.to_i
end
