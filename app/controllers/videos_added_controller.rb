class VideosAddedController < ApplicationController
  def videos_added
    after = Time.now - 1.week
    @add_video_count = Activity.fetch(:add_video, after)
    @videos_added = Kaminari.paginate_array(VideoAdded.fetch_videos_added(after)).page(page).per(per_page)
  end
end