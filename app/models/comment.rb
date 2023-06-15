class Comment < ApplicationRecord
    validates :content, presence: true

    belongs_to :author, class_name: "User"
    belongs_to :subject, polymorphic: true
end
