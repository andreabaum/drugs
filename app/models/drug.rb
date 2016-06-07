class Drug < ActiveRecord::Base
  include ApplicationHelper

  has_many :purchases, dependent: :destroy
  has_many :consumptions, dependent: :destroy

  has_many :users, -> { distinct }, through: :consumptions

  validates :name, presence: true

  enum format_type: {
    tablet: 0,
    capsule: 1,
    eye_drops: 2,
    oral_drops: 3,
    packets: 4,
    syringe: 5,
    #liquid: 6
    #oil: 7,
    #gel: 8,
    #powder: 9
  }

  def format_type_icon
    case format_type
    when 'tablet'
      'toggle-off'
    when 'capsule'
      'toggle-off'
    when 'eye_drops'
      'eye'
    when 'oral_drops'
      'tint'
    else
      'question'
    end
  end

  def consumptions_sorted
    consumptions.order(:when)
  end

  def purchases_sorted
    purchases.order(when: :desc).limit(10)
  end

  def purchases_after_reset
    if reset_at
      purchases_sorted.select { |purchase| purchase.when >= reset_at }
    else
      purchases_sorted
    end
  end

  def consumed_after_reset
    consumptions.any? ? consumptions.map(&:consumed_after_reset).inject(:+) : 0
  end

  # Return the amount currently available
  def amount_current
    if reset_at && !reset_amount.nil?
      amount = reset_amount
      purchases_after_reset.each { |i| amount += i.amount }
      amount -= consumed_after_reset
      clean_number amount
    else
      # Sum purchases amount (integer)
      purchases.sum(:amount)
    end
  end

  # Return the amount currently available, preventing unwanted decimals
  def amount_current_round
    fract = has_integer_consumptions_only? ? 1 : 2
    truncate_number(amount_current, fract)
  end

  def dose
    # Current daily dose, sum active consumptions (float)
    dose = 0
    consumptions.each { |consumption|
      dose += consumption.amount_f if consumption.is_active?
    }
    dose

    # Nicer but incorrect in test env (?)
    # consumptions.active.map(&:amount_f).inject(:+)
  end

  def dose_clean
    clean_number dose
  end

  #TODO Update to support different consumptions frequency, e.g. every 7 days
  def dose_by_user(user)
    # Current daily dose, sum active consumptions (float)
    clean_number consumptions.active.by_user(user).map(&:amount).inject(:+)
  end

  # Return true when all active consumptions are for every day
  def has_everyday_consumptions_only?(user)
    active_consumptions = consumptions.active.by_user(user)
    active_consumptions.map(&:every_days).inject(:+) == active_consumptions.size
  end

  # Return true when all active consumptions have integer amounts
  def has_integer_consumptions_only?
    consumptions.active.each { |consumption|
      return false unless consumption.amount_clean.is_a? Integer
    }
  end

  def amount_last_purchased
    (purchases.any?) ? purchases.last.amount : 0
  end

  def ends_at
    if dose && dose > 0
      Date.today + (amount_current / dose)
    else
      Date.today
    end
  end

  def ends_in
    (ends_at - Date.today).to_i
  end

  def ends_at_formatted
    format_date ends_at
  end

  # Return a user object only when all consumptions belong to the same user
  # Otherwise, when there are no consumptions or multiple users, return nil
  def user
    if users.size == 1
      users.first
    else
      nil
    end
  end

  def reset_at_date
    reset_at.to_date
  end

  # Returns a hash of attributes that were changed before the model was saved
  # http://api.rubyonrails.org/classes/ActiveModel/Dirty.html#method-i-previous_changes
  def previous_changes_clean
    excluded_params = [:updated_at]
    excluded_params << :reset_at unless previous_changes[:reset_amount]
    previous_changes.except(*excluded_params)
  end
end
