module HumanTime
  extend ActiveSupport::Concern

  def human_month_day_year_time
    created_at.strftime("%B %d, %Y at %l:%M %p")
  end

end