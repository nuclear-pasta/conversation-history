class Project < ApplicationRecord
    has_many :comments, as: :subject, dependent: :destroy
    validates :name, :state, presence: true
end
