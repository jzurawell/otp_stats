class DashboardController < ApplicationController
    def dashboard
        @tasks_total_count = Dashboard.fetch_tasks_total
        @tasks_approve_count = Dashboard.fetch_tasks_approve
        @tasks_review_count = Dashboard.fetch_tasks_review
        @tasks_translate_count = Dashboard.fetch_tasks_translate
        @tasks_subtitle_count = Dashboard.fetch_tasks_subtitle
        @member_joined_count = Dashboard.fetch_member_joined
        @reject_version_count = Dashboard.fetch_reject_version
    end
end