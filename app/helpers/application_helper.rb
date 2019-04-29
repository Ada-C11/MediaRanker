module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-danger"
      when "alert"
        "alert-warning"
      when "notice"
        "alert-info"
      else
        flash_type.to_s
      end
  end

  def show_spotlight
    works = Work.all.to_a
    unless works.nil?
      works.sort_by! { |work| Vote.where(work_id: work.id).length }
      return works.reverse[0]
    end
  end

end

