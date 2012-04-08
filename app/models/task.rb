class Task < ActiveRecord::Base
  belongs_to :user
  scope :open, where(:status => 'Open')
  scope :pending, where(:status => 'Pending')
  scope :closed, where(:status => 'Closed')
  scope :active, where("status != 'Closed'")
  scope :any # all returns an array, any will return an ActiveRelation
  
  default_scope where(:active => 1).order("created_at DESC")
  
  self.per_page = 10
    
  class << self
    def select_status
      ['Open', 'Pending', 'Closed']
    end
  end
end
