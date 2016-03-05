class Task
	class << self
		def fetch_data(user_completed_after=nil)
      host = "http://www.amara.org/"
      base_url = "api/teams/ted/tasks/"
      headers = {
        "X-api-username" => Rails.application.secrets.amara_api_username,
        "X-apikey" => Rails.application.secrets.amara_api_key
      }

      now = Time.now
      default_completed_after = now - 1.day
      completed_after = default_completed_after

      if user_completed_after.present?
        completed_after = user_completed_after
      end

      params = {
        #"language"        => language,
        "completed-after" => completed_after.to_i,
        "order_by"        => "-type",
      }

      cache_key = params.merge({
        # Make timestamp less sensitive for caching.
        'completed-after' => completed_after.to_i/(60 * 60)
      })

      Rails.cache.fetch("tasks_array_#{cache_key}", expires_in: 1.hour) do
        responses = []

  			response = HTTParty.get(
          host + base_url,
          :query => params,
          :headers => headers
        ).parsed_response

        responses.push(response)

        puts response['objects']

  			next_page = response['meta']['next']
        
        # Use looser check 'blank?' in case response is not a nil object.
        # This will return true if next_page is "", false, nil, or [].
  			
  				paginated_response = HTTParty.get(
            host + next_page,
            :query => params,
            :headers => headers
          ).parsed_response

          responses.push(paginated_response)

  				next_start_page = paginated_response['meta']['next']
  				
        
        responses
      end
		end

		# Returns total task count.
		# Task.fetch_total_count
		def fetch_total_count(user_completed_after=nil)
      hashes = Task.fetch_data(user_completed_after) # This is an array of hashes
      first_hash = hashes.first

      if first_hash.present?
        first_hash['meta']['total_count']
      else
        # TODO: What should we do if we get no results?
      end
		end

    def fetch_tasks(user_completed_after=nil)
      # [{"objects"=>    [{TASK},{TASK},{TASK}]   }]
      results_array = Task.fetch_data(user_completed_after)

      # <=== [[{TASK},{TASK},{TASK}],[{TASK},{TASK},{TASK}]...]
      tasks_arrays = results_array.map do |result|
        # {"objects"=>[{TASK}]}
        result["objects"]
      end

      # [{TASK},{TASK},{TASK},...]
      tasks = tasks_arrays.flatten

      approve_tasks   = tasks.select{|t| t['type'] == 'Approve'}
      review_tasks    = tasks.select{|t| t['type'] == 'Review'}
      translate_tasks = tasks.select{|t| t['type'] == 'Translate'}
      subtitle_tasks  = tasks.select{|t| t['type'] == 'Subtitle'}

      # 'sort_by!' sorts an array *in place*
      # contrast to 'sort_by' (no exclamation) which *returns* the sorted array
      approve_tasks.sort_by!   {|t| t['completed'].to_time }
      review_tasks.sort_by!    {|t| t['completed'].to_time }
      translate_tasks.sort_by! {|t| t['completed'].to_time }
      subtitle_tasks.sort_by!  {|t| t['completed'].to_time }

      tasks_sorted =
        approve_tasks.reverse +
        review_tasks.reverse +
        translate_tasks.reverse +
        subtitle_tasks.reverse

      tasks_sorted
    end
	end
end
