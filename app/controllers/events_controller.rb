class EventsController < ApplicationController

  # GET /Events
  def index
    @events = Event.all.reverse
  end

end
