class CategorySerialzer
    include JSONAPI::Serializer
    belongs_to :articles
    has_many :articles
    attributes :display_name, :slug
end