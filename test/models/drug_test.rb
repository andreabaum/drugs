require 'test_helper'

class DrugTest < ActiveSupport::TestCase

  test 'dose is correct' do
    drug = Drug.new
    drug.consumptions.new(when: Time.now, amount: 1, starts_at: Date.today, ends_at: Date.tomorrow)
    drug.consumptions.new(when: Time.now, amount: 0.5, starts_at: Date.today, ends_at: Date.tomorrow)

    assert_equal(2, drug.consumptions.size)

    assert_equal(1.5, drug.dose)
  end

  test 'amount_current is correct' do
    drug = Drug.new
    # Yesteray there were 9 pills
    drug.reset_at = Date.yesterday
    drug.reset_amount = 9

    # I take 1.5 every day
    drug.consumptions.new(when: Time.now, amount: 1.5, starts_at: Date.yesterday, ends_at: Date.tomorrow)

    # Then, today I have 7.5 pills
    assert_equal(7.5, drug.amount_current)
  end


  test 'ending date is correct' do
    drug = Drug.new
    # Yesteray there were 9 pills
    drug.reset_at = Date.yesterday
    drug.reset_amount = 9

    # I take 1 every day
    drug.consumptions.new(when: Time.now, amount: 1, starts_at: Date.today, ends_at: Date.today + 1.year)

    # I take 3 every 3 days
    drug.consumptions.new(when: Time.now, amount: 3, starts_at: Date.today, ends_at: Date.today + 1.year, every_days: 3)

    # Then, pills last 4 more days: (1+3) + 1 + 1 + (1+3)
    assert_equal(4, drug.ends_in)
  end


end
