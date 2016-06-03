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
    date.strftime("%d.%m.%Y")
  end

  def format_time(time)
    time.strftime("%k:%M")
  end

  def format_datetime(datetime)
    datetime.strftime("%d.%m.%Y %k:%M")
  end

  def track(resource, description)
    Event.create(when: Time.now, resource: resource.class, resource_id: resource.id, description: description)
  end
end
