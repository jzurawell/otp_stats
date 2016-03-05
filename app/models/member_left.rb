class MemberLeft
  class << self

    def fetch_members_left(after)

      results_array = []

      params = {
       "team" => "ted",
       "after" => after.to_i,
       "type" => 11,
       "team-activity" => 1,
       "limit" => 40
       }

      cache_key = params.merge({
       'after' => after.to_i/(60 * 60)
      })

      Rails.cache.fetch("members_left_#{cache_key}", expires_in: 1.hour) do

        response = HTTParty.get(
          Amara::HOST + Amara::ACTIVITY_BASE_URL,
          :query => params, :headers => Amara::HEADERS
          ).parsed_response
  
        results_array.push(response['objects'])
  
        next_page = response['meta']['next']
        until next_page.nil?
          paginated_response = HTTParty.get(
            next_page,
            :query => params, :headers => Amara::HEADERS
            ).parsed_response
  
          results_array.push(paginated_response['objects'])
          next_page = paginated_response['meta']['next']
        end

        results_array.flatten
      end
    end
  end
end
