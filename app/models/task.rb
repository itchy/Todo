class Task < ActiveRecord::Base
  belongs_to :user
  scope :open, where(:status => 'Open')
  scope :pending, where(:status => 'Pending')
  scope :closed, where(:status => 'Closed')
  
  
  class << self
    def select_status
      ['Open', 'Pending', 'Closed']
    end
  end
end
