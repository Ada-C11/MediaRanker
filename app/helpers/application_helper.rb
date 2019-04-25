module ApplicationHelper
  def list_items(works_array)
    # html_list = ""
    works_array.map do |work|
      ("<li>".html_safe + link_to(work.title, work_path(work)) +
       " by #{work.creator}" + "</li>".html_safe)
    end.join

    # return html_list
  end
end
