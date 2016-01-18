class Purchase < ActiveRecord::Base
  belongs_to :drug

  validates :drug, :presence => true

  def when_formatted
    self.when.strftime("%d.%m.%Y")
  end
end
