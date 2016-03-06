class Purchase < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :drug

  validates :drug, presence: true

  def when_formatted
    format_date self.when
  end
end
