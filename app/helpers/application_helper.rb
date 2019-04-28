module ApplicationHelper
  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end

  def show_spotlight
    works = Work.all.to_a
    if works.nil?
      flash[:notice] = "Start voting to see media on the Spotlight!"
    else
      works.sort_by! { |work| Vote.where(work_id: work.id).length }
      return works.reverse[0]
    end
  end

end

