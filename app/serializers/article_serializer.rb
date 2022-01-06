class ArticleSerializer
  include JSONAPI::Serializer
  has_many :categories

  attributes :article_type, 
            :editor, 
            :title, 
            :eyecatch_image_file_url, 
            :thumbnail_image_file_url, 
            :description, 
            :keywords,
            :lead_text, 
            :main_text, 
            :finish_text, 
            :status, 
            :publish_date,
            :display_name,
            :slug
end
