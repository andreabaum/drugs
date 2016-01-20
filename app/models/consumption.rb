class Consumption < ActiveRecord::Base
  belongs_to :drug

  validates :drug, :presence => true

  def amount_clean
    # Remove trailing zero
    i, f = amount.to_i, amount.to_f
    i == f ? i : f
  end

  def when_formatted
    self.when.strftime("%H:%M")
  end

end
