class Category < ApplicationRecord
    def self.get_category_by_id category_id
        self.where(id: category_id).last
    end
end