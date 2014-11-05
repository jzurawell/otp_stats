class Approvals
  class << self
    def fetch_approval_data
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

      #Rails.cache.fetch("approval_data_#{cache_key}", expires_in: 1.hour) do
        responses = []

        response = HTTParty.get(
          Amara::HOST + Amara::TASKS_BASE_URL,
          :query => params,
          :headers => Amara::HEADERS
        ).parsed_response

        responses.push(response)

        #next_page = response['meta']['next']
        #until next_page.nil?
        #  paginated_response = HTTParty.get(
        #      Amara::HOST + next_page,
        #      :query => params,
        #      :headers => Amara::HEADERS
        #    ).parsed_response
        #  responses.push(paginated_response)
        #  next_page = paginated_response['meta']['next']
        #end

        responses
      #end
    end

    def fetch_total_approvals
      hashes = Approvals.fetch_approval_data
      first_hash = hashes.first
     
      if first_hash.present?
        first_hash['meta']['total_count']
      end
    end

    def fetch_approval_tasks
      # [{"objects"=>    [{TASK},{TASK},{TASK}]   }]
      results_array = Approvals.fetch_approval_data

      # <=== [[{TASK},{TASK},{TASK}],[{TASK},{TASK},{TASK}]...]
      approval_arrays = results_array.map do |result|
        # {"objects"=>[{TASK}]}
        result["objects"]
      end

      # [{TASK},{TASK},{TASK},...]
      approval_tasks = approval_arrays.flatten

      p approval_tasks
    end
  end
end