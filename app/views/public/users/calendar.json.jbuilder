json.array!(@events + @images) do |item|
  if item.is_a?(Event)
    json.id "#{item.id}"
    json.title "・#{item.title.presence || '（無題）'}"
    json.start item.start || Time.current
    json.allDay true
    json.url Rails.application.routes.url_helpers.event_path(item)
    json.color "#8F9779"  
  else
    json.id "#{item.id}"
    json.title item.title.presence || '（無題）'
    json.start item.created_at || Time.current
    json.allDay true
    json.url Rails.application.routes.url_helpers.image_path(item)
    json.color "#C1694F"  
  end
end
