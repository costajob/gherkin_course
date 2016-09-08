Then(/^i should receive \$(\d+) cash$/) do |amount|
  @withdraw.call.must_equal amount.to_i
end
