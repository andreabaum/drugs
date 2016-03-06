module ApplicationHelper

  # Remove trailing zero
  def clean_number(number)
    i, f = number.to_i, number.to_f
    i == f ? i : f
  end

  def format_date(date)
    date.strftime("%d.%m.%Y")
  end

  def format_time(time)
    time.strftime("%k:%M")
  end
end
