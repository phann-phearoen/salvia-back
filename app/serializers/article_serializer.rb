class ArticleSerializer
  include JSONAPI::Serializer
  
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
            :categories_id,
            :status, 
            :publish_date
end
