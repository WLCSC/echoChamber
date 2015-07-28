json.array!(@rooms) do |room|
  json.extract! room, :id, :last_file_id_id, :password, :comment, :user_sid, :name
  json.url room_url(room, format: :json)
end
