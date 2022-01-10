class ArticleSerializer
  include JSONAPI::Serializer
  
  attributes 
            :title, 
            :eyecatch_image_file_url, 
            :thumbnail_image_file_url, 
            :description, 
            :keywords,
            :lead_text, 
            :main_text, 
            :finish_text,
            :publish_date
end
