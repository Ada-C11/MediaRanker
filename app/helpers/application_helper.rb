module ApplicationHelper
  def parse_date(date)
    date.strftime("%b %d, %Y")
  end
end
