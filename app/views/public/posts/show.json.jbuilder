json.data do
  json.items do
    json.array!(@post) do |post|
      json.id post.id
      json.user do
        json.name post.user.name
      end
      json.image url_for(post.image)
      json.title post.title
      json.introduction post.introduction
      json.address post.address
      json.latitude post.latitude
      json.longitude post.longitude
    end  
  end
end