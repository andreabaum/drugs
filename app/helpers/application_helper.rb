module ApplicationHelper

  # Hide zero decimals
  def clean_number(number)
    # Prevent trailing zero, use integer value instead
    i, f = number.to_i, number.to_f
    i == f ? i : f
  end

  # Truncate to closest integer or allowed fraction
  # http://stackoverflow.com/questions/11680519
  # Examples:
  #   2.7, 2, 1   ->  2.5
  #   2.7, 2, 2   ->  2.5
  #   2.7, 3, 2   ->  2.67
  #   2.7, 3, 1   ->  2.7
  #   3.1, 2, 1   ->  3
  #   2.5, 3, 1   ->  2.3
  #   2.6, 1, 2   ->  2
  def truncate_number(number, fract = 2, decimals = 1)
    r = (number * fract).to_i / fract.to_f
    r.to_i == r ? r.to_i : r.round(decimals)
  end

  def format_date(date)
    I18n.l(date, format: :date)
  end

  def format_time(time)
    I18n.l(time, format: :time)
  end

  def format_datetime(datetime)
    I18n.l(datetime, format: :datetime)
  end

  # Compare multiple times, ignoring the dates
  # [2000-01-01 14:30:00 UTC:Time, 1970-01-01 14:30:00 UTC:Time] -> true
  # [2000-01-01 14:30:00 UTC:Time, 2000-01-01 14:00:00 UTC:Time] -> false
  def eql_times? times_array
    times_array.map!{ |t| format_time(t) if t }.uniq.size == 1
  end

  # Create an event item
  def track(resource, description)
    Event.create(when: Time.now, resource: resource.class, resource_id: resource.id, description: description)
  end

  # Return the value for the given configuration parameter
  def get_config parameter
    # Get default value from application.yml or common.yml
    #Figaro.env.send(parameter)
    ENV[parameter.to_s]
  end

  # Return the value for the given JSON configuration parameter
  def get_config_json parameter, key
    JSON.parse(get_config(parameter))[key.to_s]
  end

end
