Feature: withdraw cash from account
  In order to get some cash
  As a bank account user
  I want to withdraw a given amount

Background:
  Given i have $100 in my account

Scenario:
  But my PIN is blocked
  When i withdraw $50
  Then my request should be refuted
  And i am forced to reset my PIN

Scenario Outline: Withdraw fixed amount
  Given i have <balance> in my account
  When i withdraw the fixed amount of <withdrawal>
  Then i should <outcome>
  And the balance of my account should be <remaining>

  Examples: Successful withdrawal
    | balance | withdrawal | outcome | remaining |
    | $500 | $50 | receive $50 cash | $450 |

  Examples: Attempt to withdraw too much
    | balance | withdrawal | outcome | remaining |
    | $100 | $200 | see an error message | $100 |
