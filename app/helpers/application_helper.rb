module ApplicationHelper
  def error_list(model)
    error_list = ""
    if model && model.errors
      error_list += "<ul>"
      model.errors.messages.each do |column, error|
        error.each do |message|
          error_list += "<li>#{column}: #{message}</li>"
        end
      end
      error_list += "</ul>"
    end
    return error_list.html_safe
  end
end
