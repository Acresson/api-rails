class Article < ApplicationRecord
    belongs_to :user
  
    validates :title, presence: true
    validates :content, presence: true
  
    validates :private, inclusion: { in: [true, false] }
  end
  