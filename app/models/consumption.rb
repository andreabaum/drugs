class Consumption < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :drug
  belongs_to :user

  validates :drug, :presence => true

  scope :active, -> { where('? >= starts_at AND ? <= ends_at', Date.today, Date.today) }
  scope :not_active, -> { where('? < starts_at OR ? > ends_at', Date.today, Date.today) }

  scope :by_user, -> (user_id) { where(user_id: user_id) }
  scope :by_drug, -> (drug_id) { where(drug_id: drug_id) }

  # TODO not working?
  # scope :by_time, -> (t) { where('when = ?', t) }

  def amount_clean
    clean_number amount
  end

  def when_formatted
    self.when.strftime("%k:%M")
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
      days = [ends_at, Date.today].min - [starts_at, drug.reset_at_date].max
      days * amount
    else
      0
    end
  end
end
