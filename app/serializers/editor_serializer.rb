class EditorSerializer
  include JSONAPI::Serializer
  has_many :articles
  attributes :name, :icon_image_file_url, :profile, :email
end
