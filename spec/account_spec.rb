require "spec_helper"
require "bank/account"

describe Bank::Account do
  let(:pin) { "1234" }
  let(:wrong_pin) { "xxxx" }
  let(:account) { Bank::Account.new("Elvis", 100_000_000, pin) }

  it "must initialize the account" do
    account.must_be_instance_of Bank::Account
    account.name.must_equal "Elvis"
  end

  it "must get balance with right PIN" do
    account.balance(pin).must_equal 100_000_000
  end

  it "must deposit cash with right PIN" do
    account.deposit(1_000_000, pin)
    account.balance(pin).must_equal 101_000_000
  end

  it "must withdraw cash with right PIN" do
    account.withdraw(1_000_000, pin)
    account.balance(pin).must_equal 99_000_000
  end

  it "must be able to change PIN by providing old one" do
    account.change_pin(pin, "2222")
    account.instance_variable_get(:@pin).must_equal "2222"
  end

  it "must be able to reset PIN by providing right one" do
    account.reset_pin!(pin)
    account.instance_variable_get(:@pin).must_equal "0000"
  end
  
  describe "textual amount" do
    it "must support deposit of textual amount" do
      account.deposit("1_000_000", pin)
      account.balance(pin).must_equal 101_000_000
    end

    it "must support withdraw of textual amount" do
      account.withdraw("1_000_000", pin)
      account.balance(pin).must_equal 99_000_000
    end
  end

  describe "wrong PIN" do
    it "must fail balance with wrong PIN" do
      -> { account.balance(wrong_pin) }.must_raise Bank::Account::WrongPINError
    end

    it "must fail deposit with wrong PIN" do
      -> { account.deposit(1_000_000, wrong_pin) }.must_raise Bank::Account::WrongPINError
    end

    it "must fail withdraw with wrong PIN" do
      -> { account.withdraw(1_000_000, wrong_pin) }.must_raise Bank::Account::WrongPINError
    end

    it "must fail changing PIN by providing a wrong one" do
      -> { account.change_pin(wrong_pin, "2222") }.must_raise Bank::Account::WrongPINError
    end
  end

  describe "blocked PIN" do
    before do
      Bank::Account::WRONG_PIN_MAX_TRIES.times do
        begin
          account.balance("0000")
        rescue Bank::Account::WrongPINError
        end
      end
    end

    it "must fail balance if PIN is blocked" do
      -> { account.balance(pin) }.must_raise Bank::Account::BlockedPINError
    end

    it "must fail deposit if PIN is blocked" do
      -> { account.deposit(1_000_000, pin) }.must_raise Bank::Account::BlockedPINError
    end

    it "must fail withdraw if PIN is blocked" do
      -> { account.withdraw(1_000_000, pin) }.must_raise Bank::Account::BlockedPINError
    end

    it "must fail PIN changing if PIN is blocked" do
      -> { account.change_pin(pin, "2222") }.must_raise Bank::Account::BlockedPINError
    end

    it "must be able to unlock PIN by resetting it" do
      account.reset_pin!(pin)
      account.balance("0000").must_equal 100_000_000
    end

    it "must fail unlocking PIN with wrong one" do
      account.reset_pin!(wrong_pin)
      -> { account.balance(pin) }.must_raise Bank::Account::BlockedPINError
    end 
  end
end
