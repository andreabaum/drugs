class Consumption < ActiveRecord::Base
  belongs_to :drug

  validates :drug, :presence => true

  scope :active, -> { where('? >= starts_at AND ? <= ends_at', Date.today, Date.today) }

  def amount_clean
    # Remove trailing zero
    i, f = amount.to_i, amount.to_f
    i == f ? i : f
  end

  def when_formatted
    self.when.strftime("%H:%M")
  end

  def starts_at_formatted
    starts_at.strftime("%d.%m.%Y")
  end

  def ends_at_formatted
    ends_at.strftime("%d.%m.%Y")
  end

  def is_active?
    Date.today >= starts_at && Date.today <= ends_at
  end

  # Return the number days the consumption was active, after the drug has been reset
  def consumed_after_reset
    if (starts_at..ends_at).overlaps?(drug.reset_at..Date.today)
      days = [ends_at, Date.today].min - [starts_at, drug.reset_at].max
      days * amount
    else
      0
    end
  end
end
