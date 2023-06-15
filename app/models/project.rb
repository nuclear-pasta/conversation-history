class Project < ApplicationRecord
    has_many :comments, as: :subject, dependent: :destroy
    validates :name, :state, presence: true
    
    state_machine :state, initial: :draft do
        state :draft
        state :submitted
        state :approved
        state :rejected
        state :cancelled
    
        event :submit do
          transition draft: :submitted
        end
    
        event :approve do
          transition submitted: :approved
        end
    
        event :reject do
          transition submitted: :rejected
        end
    
        event :cancel do
          transition any => :cancelled
        end
      end
end
