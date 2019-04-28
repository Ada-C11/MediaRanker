module ApplicationHelper
  

  def show_spotlight
    works = Work.all.to_a
    if works.nil?
      flash[:message] = "Start voting to see media on the Spotlight!"
    else
      works.sort_by! { |work| Vote.where(work_id: work.id).length }
      return works.reverse[0]
    end
  end

end

