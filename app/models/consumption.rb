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

  def amount_f
    amount / every_days
  end

  def amount_clean
    clean_number amount
  end

  def when_formatted
    format_time self.when
  end

  def starts_at_formatted
   format_date starts_at
  end

  def ends_at_formatted
    format_date ends_at
  end

  def is_active? date = Date.today
    (starts_at..ends_at).cover?(date)
  end

  def is_past?
    ends_at < Date.today
  end

  # Return the number days the consumption was active, after the drug has been reset
  def consumed_after_reset
    if (starts_at..ends_at).overlaps?(drug.reset_at..Date.today)
      days = [ends_at, Date.today].min - [starts_at, drug.reset_at_date].max
      days * amount_f
    else
      0
    end
  end

  # Returns a hash of attributes that were changed before the model was saved
  # http://api.rubyonrails.org/classes/ActiveModel/Dirty.html#method-i-previous_changes
  def previous_changes_clean
    excluded_params = [:updated_at]
    excluded_params << :when if eql_times?(previous_changes[:when])
    previous_changes.except(*excluded_params)
  end

  def next_occurrence
    schedule.next_occurrence
  end

  def occurs_today?
    schedule.occurs_on? Date.today
  end

  def occurs_tomorrow?
    schedule.occurs_on? Date.tomorrow
  end

  def occurs_on? date = Date.today
    schedule.occurs_on?(date)
  end

  private

  def schedule
    starting_time = Time.parse("#{starts_at} #{when_formatted}")
    schedule = IceCube::Schedule.new(starting_time)
    schedule.add_recurrence_rule(
      IceCube::Rule.daily(every_days)
    )
    schedule
  end
end
