class CategorySerialzer
    include JSONAPI::Serializer
       
    attributes :display_name, :slug
end