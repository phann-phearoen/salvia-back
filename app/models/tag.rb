class Tag < ApplicationRecord
    def self.get_tag_by_id tag_id
        self.where(id: tag_id).last
    end
end