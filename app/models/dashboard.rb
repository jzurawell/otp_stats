class Dashboard
  class << self

    def fetch_tasks_total
      now = Time.now
      completed_after = now - 1.week

      params = {
       "completed-after" => completed_after.to_i
      }

      cache_key = params.merge({
        # Make timestamp less sensitive for caching.
        'completed-after' => completed_after.to_i/(60 * 60)
      })

      Rails.cache.fetch("total_tasks_#{cache_key}", expires_in: 1.hour) do
        response = HTTParty.get(
          Amara::HOST + Amara::TASKS_BASE_URL,
          :query => params,
          :headers => Amara::HEADERS
        ).parsed_response

        response['meta']['total_count']
      end
    end

    def fetch_tasks_approve
      now = Time.now
      completed_after = now - 1.week
      
      params = {
        "completed-after" => completed_after.to_i,
        "type" => "Approve"
      }

      cache_key = params.merge({
        # Make timestamp less sensitive for caching.
        'completed-after' => completed_after.to_i/(60 * 60)
      })

      Rails.cache.fetch("approve_tasks_#{cache_key}", expires_in: 1.hour) do
        response = HTTParty.get(
          Amara::HOST + Amara::TASKS_BASE_URL,
          :query => params,
          :headers => Amara::HEADERS
        ).parsed_response

        response['meta']['total_count']
      end
    end

    def fetch_tasks_review
      now = Time.now
      completed_after = now - 1.week

      params = {
        "completed-after" => completed_after.to_i,
        "type" => "Review"
      }

      cache_key = params.merge({
        # Make timestamp less sensitive for caching.
        'completed-after' => completed_after.to_i/(60 * 60)
      })

      Rails.cache.fetch("review_tasks_#{cache_key}", expires_in: 1.hour) do
        response = HTTParty.get(
          Amara::HOST + Amara::TASKS_BASE_URL,
          :query => params,
          :headers => Amara::HEADERS
        ).parsed_response

        response['meta']['total_count']
      end
    end

    def fetch_tasks_translate
      now = Time.now
      completed_after = now - 1.week

        params = {
        "completed-after" => completed_after.to_i,
        "type" => "Translate"
      }

      cache_key = params.merge({
        # Make timestamp less sensitive for caching.
        'completed-after' => completed_after.to_i/(60 * 60)
      })

      Rails.cache.fetch("translate_tasks_#{cache_key}", expires_in: 1.hour) do
        response = HTTParty.get(
          Amara::HOST + Amara::TASKS_BASE_URL,
          :query => params,
          :headers => Amara::HEADERS
        ).parsed_response

        response['meta']['total_count']
      end
    end

    def fetch_tasks_subtitle
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

      Rails.cache.fetch("subtitle_tasks_#{cache_key}", expires_in: 1.hour) do
        response = HTTParty.get(
          Amara::HOST + Amara::TASKS_BASE_URL,
          :query => params,
          :headers => Amara::HEADERS
        ).parsed_response

        response['meta']['total_count']
      end
    end
  end
end
