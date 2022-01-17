class Api::V1::ArticlesController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def admin_index
        articles = Article.order(:creation_date).page(page || 1).per(10) 
        
        response = []

        articles.each do |article|
            obj = {}

            obj["id"] = article.id

            if article.tag_ids?
                @tags = []
                article.tag_ids.each do |t|
                    tag = Tag.get_tag_by_id(t)
                    if tag.present?
                        @tags.push(tag.display_name)
                    else
                        nil
                    end
                end
                obj["tags"] = @tags
            else
                nil
            end

            if article.category_ids?
                @categories = []
                article.category_ids.each do |cat|
                    category = Category.get_category_by_id(cat)
                    if category.present?
                        @categories.push(category.display_name)
                    else
                        nil
                    end
                end
                obj["categories"] = @categories
            else
                nil
            end
            
            if article.editor_id?
                editor = Editor.get_editor_by_id(article.editor_id)
                if editor.present?
                    obj["writer"] = editor.name 
                else
                    obj["writer"] = "Unknown"
                end
            else
                nil
            end

            obj["title"] = article.title 

            obj["created_at"] = article.creation_date

            response.push(obj)
        end
        
        render json: response
    end

    private
    def page
        Article.page(10).total_pages
    end
    def self.get_article_by_id article_id
        self.where(id: article_id).last
    end
end