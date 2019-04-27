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
    max_votes = Vote.select{ |v| v.work_id }.max
    media_spotlight = Work.find(max_votes.work_id)
    return media_spotlight
  end

  def user_collection(user)
    user_votes = Vote.where(user_id: user.id)
    # work_ids = user_votes.select{ |v| v.work_id }.uniq
    # work_ids.each do |work|
    #   works = Work.where(id: work.work_id)
    #   return works
    ##end
  end

end

