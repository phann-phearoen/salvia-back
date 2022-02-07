class Api::V1::ArticleController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def total_pages
        total_count = Article.page(1).per(params[:per]).total_pages
        render json: total_count
    end

    def admin_index
        # articles = Article.order('creation_date DESC')
        # render json: articles, only: [:id, :title, :editor_id, :category_ids, :tag_ids, :creation_date]

        reverser = Article.order(creation_date: :desc)

        page = get_page(params[:page])
        per = params[:per] || 10

        articles = reverser.order(:creation_date).page(page).per(per)

        total_count = Article.count
        
        response = {
            # articles: articles.select(:id, :title, :editor_id, :category_ids, :tag_ids, :creation_date),
            articles: tailor_response(articles),
            total_count: total_count
        }
        
        render json: response
    end

    def search_article
        @title = params[:title] 
        articles = Article.where("title like ? ", "%#{@title}%")        
        render json: tailor_response(articles)
    end
    
    private
    def get_page page_param
        if page_param
            page_param
        else
            Article.page(1).per(10).total_pages
        end
    end
    def self.get_article_by_id article_id
        self.where(id: article_id).last
    end
    def tailor_response articles
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
                    end
                end
                obj["tags"] = @tags
            end
            if article.category_ids?
                @categories = []
                article.category_ids.each do |cat|
                    category = Category.get_category_by_id(cat)
                    if category.present?
                        @categories.push(category.display_name)
                    end
                end
                obj["categories"] = @categories
            end            
            if article.editor_id?
                editor = Editor.get_editor_by_id(article.editor_id)
                if editor.present?
                    obj["writer"] = editor.name 
                else
                    obj["writer"] = "Unknown"
                end
            end
            obj["title"] = article.title
            obj["created_at"] = article.creation_date
            response.push(obj)
        end        
        return response
    end
end