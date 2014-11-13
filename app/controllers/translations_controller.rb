class TranslationsController < ApplicationController
  def translations
    @total_count = Translation.fetch_translation_total
    @translation_tasks = Kaminari.paginate_array(Translation.fetch_translation_tasks).page(page).per(per_page)
  end
end