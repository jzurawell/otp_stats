class Activity
  include HTTParty
  # Uncomment the below line to debug raw HTTP requests
  # debug_output $stdout

  TYPE_MAPPING = {
    :reject_version  => 10,
    :decline_version => 14,
    :comment         => 3,
    :add_version     => 4,
    :add_video       => 1
  }

  TEAM_ACTIVITY_MAPPING = {
    :member_joined   => 9,
    :member_left     => 11
  }

  class << self
  # Activity.fetch(:member_joined, Time.now - 1.week)
    def fetch(type, after)
      params = {
        "team" => "ted",
        "after" => after.to_i,
        "type" => TYPE_MAPPING[type]
      }

      cache_key = params.merge({
       'after' => after.to_i/(60 * 60)
      })

      Rails.cache.fetch("#{type}_#{cache_key}", expires_in: 1.hour) do

        response = get(
          Amara::HOST + Amara::ACTIVITY_BASE_URL,
          :query => params,
          :headers => Amara::HEADERS
        ).parsed_response
        response.try(:[], 'meta').try(:[], 'total_count')
      end
    end

    def fetch_team_activity(type, after)
      params = {
        "team" => "ted",
        "after" => after.to_i,
        "type" => TEAM_ACTIVITY_MAPPING[type],
        "team-activity" => 1
      }

      cache_key = params.merge({
        'after' => after.to_i/(60 * 60)
      })

      Rails.cache.fetch("team_activity_#{cache_key}", expires_in: 1.hour) do

        response = get(
          Amara::HOST + Amara::ACTIVITY_BASE_URL,
          :query => params,
          :headers => Amara::HEADERS
        ).parsed_response
        response.try(:[], 'meta').try(:[], 'total_count')
      end
    end
  end
end
