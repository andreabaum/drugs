class Consumption < ActiveRecord::Base
  belongs_to :drug
  belongs_to :user

  validates :drug, :presence => true

  scope :active, -> { where('? >= starts_at AND ? <= ends_at', Date.today, Date.today) }
  scope :not_active, -> { where('? < starts_at OR ? > ends_at', Date.today, Date.today) }

  scope :by_user, -> (user_id) { where(user_id: user_id) }

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
    (starts_at..ends_at).include?(Date.today)
  end

  def is_past?
    ends_at < Date.today
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
