class Drug < ActiveRecord::Base
  has_many :purchases

  validates :name, :presence => true

  def purchases_sorted
    purchases.order(when: :desc).limit(10)
  end

  def purchases_after_reset
    if reset_at
      purchases_sorted.select{ |purchase| purchase.when >= reset_at }
    else
      purchases_sorted
    end
  end

  def amount_current
    if reset_at && dose && !reset_amount.nil?
      amount = reset_amount
      purchases_after_reset.each{ |i| amount += i.amount }
      amount - dose*(Date.today - reset_at)
      # Remove trailing zero
      i, f = amount.to_i, amount.to_f
      i == f ? i : f
    else
      purchases.sum(:amount)
    end
  end

  def dose_clean
    # Remove trailing zero
    i, f = dose.to_i, dose.to_f
    i == f ? i : f
  end

  def amount_last_purchased
    (purchases.any?) ? purchases.last.amount : 0
  end

  def ends_at
    if dose
      Date.today + (amount_current/dose)
    else
      Date.today
    end
  end

  def ends_in
    (ends_at - Date.today).to_i
  end

  def ends_at_formatted
    ends_at.strftime("%d.%m.%Y")
  end
end