json.array!(@raiders) do |raider|
  json.extract! raider, :id, :name, :email, :participating, :auto
  json.url raider_url(raider, format: :json)
end
