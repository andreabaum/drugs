require 'test_helper'

class DrugTest < ActiveSupport::TestCase


  test 'dose is correct' do
    drug = Drug.new
    drug.consumptions.new(when: Time.now, amount: 1)
    drug.consumptions.new(when: Time.now, amount: 0.5)
    assert drug.consumptions.any?
    assert_equal(1.5, drug.dose)
  end

  test 'amount_current is correct' do
    drug = Drug.new
    # Yesteray I had 9 pills
    drug.reset_at = Date.yesterday
    drug.reset_amount = 9
    # I take 1.5 every day
    drug.consumptions.new(when: Time.now, amount: 1.5)
    # Then, today I have 7.5 pills
    assert_equal(7.5, drug.amount_current)
  end
end
