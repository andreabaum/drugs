class Drug < ActiveRecord::Base
  has_many :purchases
  def purchases_sorted
    purchases.order(when: :desc).limit(5)
  end

  def current_amount
    purchases.sum(:amount)
  end

  def ends_at
    purchases.last.when
  end
end
