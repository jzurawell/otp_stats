class ActivityController < ApplicationController
  def activity
    default_after = Time.now - 1.week
    after = params[:after] || default_after

    @member_joined_count = Activity.fetch_team_activity(:member_joined, after)
    @member_left_count = Activity.fetch_team_activity(:member_left, after)
    @reject_version_count = Activity.fetch(:reject_version, after)
    @decline_version_count = Activity.fetch(:decline_version, after)
    @comment_count = Activity.fetch(:comment, after)
    @add_version_count = Activity.fetch(:add_version, after)
    @add_video_count = Activity.fetch(:add_video, after)

    #if  @member_joined_count.nil? ||
    #    @member_left_count.nil? ||
    #    @reject_version_count.nil? ||
    #    @decline_version_count.nil? ||
    #    @comment_count.nil? ||
    #    @add_version_count.nil? ||
    #    @add_video_count.nil?
    #        return render inline: '#amarasux'
    #end
  end
end
