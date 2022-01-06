class EditorSerializer
  include JSONAPI::Serializer
  
  attributes :name, :icon_image_file_url, :profile, :email
end
