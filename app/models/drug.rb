class Drug < ActiveRecord::Base
  has_many :purchases

  def current_amount
    purchases.sum(:amount)
  end
end
