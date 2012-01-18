class Task < ActiveRecord::Base
  belongs_to :user
  scope :open, where(:status => 'Open')
  scope :pending, where(:status => 'Pending')
  scope :closed, where(:status => 'Closed')
  scope :active, where("status != 'Closed'")
  
  default_scope where(:active = 1)
  
  
  class << self
    def select_status
      ['Open', 'Pending', 'Closed']
    end
  end
end
