module WorksHelper
  def list_works(category)
    works_rows = ""
    works_in_category_sorted = Work.where(category: category).sort_by { |work| work.votes.count }.reverse
    works_in_category_sorted.each do |work|
      works_rows += "<tr>" +
                    "<td>#{work.votes.count}</td>" +
                    "<td>#{link_to work.title, work_path(work.id)}</td>" +
                    "<td>#{work.creator}</td>" +
                    "<td>#{work.publication_year}</td>"
      vote = work.votes.find_by(user_id: session[:user_id], value: 1)
      if vote
        works_rows += "<td>#{link_to "Undo Upvote", vote_path(id: vote.id), method: :delete, class: "btn btn-primary"}</td>"
      else
        works_rows += "<td>#{link_to "Upvote", work_votes_path(work_id: work.id), method: :post, class: "btn btn-primary"}</td>"
      end

      vote = work.votes.find_by(user_id: session[:user_id], value: -1)
      if vote
        works_rows += "<td>#{link_to "Undo Downvote", vote_path(id: vote.id, value: -1), method: :delete, class: "btn btn-primary"}</td>"
      else
        works_rows += "<td>#{link_to "Downvote", work_votes_path(work_id: work.id, value: -1), method: :post, class: "btn btn-primary"}</td>"
      end
    end
    return works_rows.html_safe
  end

  def vote_list(work)
    voters = ""
    work.votes.each do |vote|
      voters += "<tr>" +
                "<td>#{link_to vote.user.username, user_path(vote.user.id)}</td>" +
                "<td>#{vote.created_at.strftime("%B %d, %Y")}</td>" +
                "<td>#{vote.value == -1 ? "downvote" : "upvote"}"
      "</tr>"
    end
    return voters.html_safe
  end
end
