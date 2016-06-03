class Event < ActiveRecord::Base
  include ApplicationHelper

  def get_resource
    Object.const_get(resource).find_by_id(resource_id.to_i)
  end

  def when_formatted
    format_datetime self.when
  end
end
