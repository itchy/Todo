class User < ActiveRecord::Base
  has_secure_password
  
  has_many :tasks
  
  
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  # validates :email, :uniqueness => true 
  validates :sms_number, :format => { :with => /\A[(]*([0-9]){3}[)-\. ]*([0-9]{3})[-\.]*([0-9]{4})\Z/i, :on => :create, :message => "Phone Number is invalid"}
  validates :password, :presence => true, :on => :create
  
  def display_name
    "#{first_name} #{last_name}"
  end
  
  def create_task(body)
    if body[/^\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z$/i]
      # if the total content of the text is an email address, update the users email address
      self.email = body
      self.save
    else
      task = tasks.new({:status => "Open", :description => body}) 
      task.save 
    end
  end
  
  class << self
    def select_user
      self.all.map {|u| [u.display_name, u.id] }
    end
    
    def find_or_create_by_sms_number(number)
      creator = self.find_by_sms_number(number) || User.new({:sms_number => number, :password => 'leclerk', :email => "unknown@sample.com"}) 
    end
  end  
end
