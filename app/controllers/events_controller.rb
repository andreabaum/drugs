class EventsController < ApplicationController

  # GET /Events
  def index
    @events = Event.all.sort_by(&:when).reverse
  end

end
