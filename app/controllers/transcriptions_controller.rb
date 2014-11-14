class TranscriptionsController < ApplicationController
  def transcriptions
    @total_count = Transcription.fetch_transcription_total
    @transcription_tasks = Kaminari.paginate_array(Transcription.fetch_transcription_tasks).page(page).per(per_page)
  end
end