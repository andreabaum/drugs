class User < ActiveRecord::Base
  has_many :consumptions
  has_many :drugs, -> { distinct }, through: :consumptions

  # Note: limit to 5 items
  def consumptions_times
    consumptions.active.order(:when).map(&:when).uniq.first(5)
  end
end
