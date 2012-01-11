class Task < ActiveRecord::Base
  belongs_to :user
  
  
  class << self
    def select_status
      ['Open', 'Pending', 'Closed']
    end
  end
end
