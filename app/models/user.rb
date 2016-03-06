class User < ActiveRecord::Base
  include ApplicationHelper

  has_many :consumptions
  has_many :drugs, -> { distinct }, through: :consumptions

  def consumptions_times
    consumptions.active.order(:when).map(&:when).uniq
  end

  def drug_active?(drug)
    consumptions.by_drug(drug).active.any?
  end
end
