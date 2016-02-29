class Drug < ActiveRecord::Base
  has_many :purchases, dependent: :destroy
  has_many :consumptions, dependent: :destroy

  validates :name, :presence => true

  def consumptions_sorted
    consumptions.order(:when)
  end

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

  def consumed_after_reset
    consumptions.any?  ? consumptions.map(&:consumed_after_reset).inject(:+) : 0
  end

  def amount_current
    if reset_at && !reset_amount.nil?
      amount = reset_amount
      purchases_after_reset.each{ |i| amount += i.amount }
      amount -= consumed_after_reset
      # Remove trailing zero
      i, f = amount.to_i, amount.to_f
      i == f ? i : f
    else
      # Sum purchases amount (integer)
      purchases.sum(:amount)
    end
  end

  def dose
    # Current daily dose, sum active consumptions (float)
    consumptions.active.map(&:amount).inject(:+)
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
    if dose && dose > 0
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
