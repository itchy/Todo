class User < ActiveRecord::Base
  has_secure_password
  
  has_many :tasks
  default_scope where(:active => 1)
  
  
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  # validates :email, :uniqueness => true 
  validates :sms_number, :format => { :with => /^\+.[0-9]{9,10}$/i, :on => :create, :message => "Phone Number is invalid"}
  validates :password, :presence => true, :on => :create
  
  def display_name
    if first_name && last_name
      "#{first_name} #{last_name}"
    else
      "#{sms_number}"
    end  
  end
  
  def create_task(body)
    if body[/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i]
      # if the total content of the text is an email address, update the users email address
      self.email = body
      self.save
    else
      task = self.tasks.new({:status => "Open", :description => body}) 
      task.save 
    end
  end
  
  class << self
    def select_user
      self.all.map {|u| [u.display_name, u.id] }
    end
    
    def find_or_create_by_sms_number(number)
      Rails.logger.info "User.find_or_create_gy_sms(#{number})"
      creator = self.find_by_sms_number(number) || User.new({:sms_number => number, :password => 'leclerk', :email => "unknown@sample.com"})
      if creator.save
        Rails.logger.info "creator.save"
        creator
      else
        creator.errors.full_messages.each do |msg|
          Rails.logger.info msg
        end  
        User.first
      end 
      rescue
        Rails.logger.info "rescue" 
        User.first 
    end
  end  
end
