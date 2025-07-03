json.array!(@events + @images) do |item|
  json.id item.id
  json.title(
    if item.respond_to?(:title)
     item.title
    else
     "投稿 : #{item.caption.to_s.truncate(10)}
    end
  )

  json.start item.try(:date) || item.create_at

  json.url(
    if item.is_a?(Event)
     Rails.application.toutes.url_helpers.event_path(item)
    else
     Rails.application.routes.url_helpers.image_path(item)
    end
  )
end