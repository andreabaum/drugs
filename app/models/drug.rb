class Drug < ActiveRecord::Base
  has_many :purchases

  validates :name, :presence => true

  def purchases_sorted
    purchases.order(when: :desc).limit(5)
  end

  def amount_current
    purchases.sum(:amount)
  end

  def amount_last_purchased
    purchases.last.amount
  end

  def ends_at
    purchases.last.when
  end
end
