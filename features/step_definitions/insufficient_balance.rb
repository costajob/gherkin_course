Then(/^i should see an error message$/) do
  -> { @withdraw.call }.must_raise Bank::Account::InsufficientBalanceError
end
