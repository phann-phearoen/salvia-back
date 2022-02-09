class Api::V1::ArticleController < ApplicationController
    skip_before_action :doorkeeper_authorize!, except: %i[new]

    def admin_index
        # articles = Article.order('creation_date DESC')
        # render json: articles, only: [:id, :title, :editor_id, :category_ids, :tag_ids, :creation_date]

        reverser = Article.order(id: :desc)

        page = params[:page] || 1
        per = params[:per] || 10

        articles = reverser.page(page).per(per)

        total_count = Article.count
        
        render json: response = {
            # articles: articles.select(:id, :title, :editor_id, :category_ids, :tag_ids, :creation_date),
            articles: tailor_response(articles),
            total_count: total_count
        }
    end

    def search_article
        @title = params[:title] 
        articles = Article.where("title like ? ", "%#{@title}%") 
        total_count = articles.count 

        render json: response = {
            articles: tailor_response(articles),
            total_count: total_count
        }
    end

    def view_article 
        article = Article.where(id: params[:id])
        render json: article
    end

    def get_article_by_id
        article = Article.where(id: params[:id]).last

        response = []
        obj = {}
        obj["id"] = article.id
        if article.tag_ids?
            @tags = []
            article.tag_ids.each do |t|
                tag = Tag.get_tag_by_id(t)
                temp = {}
                if tag.present?
                    temp["id"] = tag.id 
                    temp["display_name"] = tag.display_name
                    @tags.push(temp)
                end
            end
            obj["tags"] = @tags
        end
        if article.category_ids?
            @categories = []
            article.category_ids.each do |cat|
                category = Category.get_category_by_id(cat)
                temp = {}
                if category.present?
                    temp["id"] = category.id 
                    temp["display_name"] = category.display_name
                    @categories.push(temp)
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
        obj["lead_text"] = article.lead_text
        obj["main_text"] = article.main_text
        response.push(obj)

        render json: response
    end    
    
    private
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