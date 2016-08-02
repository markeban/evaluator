module HumanTime

  def human_month_day_year_time
    updated_at.strftime("%B %d, %Y at %l:%M %p")
  end


end