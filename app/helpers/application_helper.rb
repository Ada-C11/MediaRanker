module ApplicationHelper
  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end

  def spotlight
    works = Work.all.to_a
    works.sort_by! { |work| Vote.where(work_id: work.id).length }
    if works[0].nil?
      flash[:notice] = "Start voting to see your title on the Spotlight!"
    else
      return works.reverse[0]
    end
  end

end

