class Transcription
  class << self
    def fetch_transcription_total
      now = Time.now
      completed_after = now - 1.week
      
      params = {
        "completed-after" => completed_after.to_i,
        "type" => "Subtitle"
      }

      cache_key = params.merge({
        # Make timestamp less sensitive for caching.
        'completed-after' => completed_after.to_i/(60 * 60)
      })

      Rails.cache.fetch("transcription_total_#{cache_key}", expires_in: 1.hour) do

        response = HTTParty.get(
          Amara::HOST + Amara::TASKS_BASE_URL,
          :query => params,
          :headers => Amara::HEADERS
        ).parsed_response

        response['meta']['total_count']
      end
    end

    def fetch_transcription_tasks
      now = Time.now
      completed_after = now - 1.week
      
      params = {
        "completed-after" => completed_after.to_i,
        "type" => "Subtitle",
        "limit" => 40
      }

      cache_key = params.merge({
        # Make timestamp less sensitive for caching.
        'completed-after' => completed_after.to_i/(60 * 60)
      })

      Rails.cache.fetch("transcription_tasks_#{cache_key}", expires_in: 1.hour) do

        response = HTTParty.get(
          Amara::HOST + Amara::TASKS_BASE_URL,
          :query => params,
          :headers => Amara::HEADERS
        ).parsed_response  

        results_array = []
  
        results_array.push(response['objects'])

        next_page = response['meta']['next']
        until next_page.nil?
          paginated_response = HTTParty.get(
              next_page,
              :query => params,
              :headers => Amara::HEADERS
            ).parsed_response
          results_array.push(paginated_response['objects'])
          next_page = paginated_response['meta']['next']
        end

        results_array.flatten.reverse
      end
    end
  end
end