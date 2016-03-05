class TranscriptionsController < ApplicationController
  def transcriptions
    lang = params["lang"]
    @total_count = Transcription.fetch_transcription_total
    transcription_tasks_all = Transcription.fetch_transcription_tasks
    @transcription_tasks = Kaminari.paginate_array(transcription_tasks_all).page(page).per(per_page)
    @language_items = transcription_tasks_all.map { |task| 
        task["language"]
        }.uniq
    puts @language_items
  end
end