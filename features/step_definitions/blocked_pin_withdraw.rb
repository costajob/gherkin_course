Given(/^my PIN is blocked$/) do
  Bank::Account::WRONG_PIN_MAX_TRIES.times do
    begin
      @account.balance("1234")
    rescue Bank::Account::WrongPINError
    end
  end
end

When(/^i withdraw \$(\d+)$/) do |amount|
  @amount = amount
end

Then(/^my request should be refuted$/) do
  -> { @account.withdraw(@amount, "0000") }.must_raise Bank::Account::BlockedPINError
end

Then(/^i am forced to reset my PIN$/) do
  @account.reset_pin!("0000")
  @account.balance("0000").must_equal 100
end
