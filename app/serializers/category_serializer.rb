class CategorySerializer
    include JSONAPI::Serializer    
    attributes :display_name, :slug, :host_user_id
end