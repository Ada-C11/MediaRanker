
class LandingController < ApplicationController
  def index
    @work = Work.top_media
    @vote_count = @work.votes.length
  end
end
