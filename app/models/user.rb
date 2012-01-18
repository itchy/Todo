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
    elsif email == "unknown@sample.com"
      sms_number
    else
      email  
    end  
  end
  
  def create_task(body)
    if body[/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i]
      # if the total content of the task is an email address, update the users email address
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
      Rails.logger.debug "User.find_or_create_by_sms(#{number})"
      creator = self.find_by_sms_number(number) || User.new({:sms_number => number, :password => 'leclerk', :email => "unknown@sample.com"})
      if creator.save
        Rails.logger.info "creator.save"
        creator
      else
        creator.errors.full_messages.each do |msg|
          Rails.logger.warn msg
        end  
        User.first
      end 
      rescue
        Rails.logger.error "RESCUE in find_or_create_by_sms_number(#{number})" 
        User.first 
    end
    
    def find_or_create_by_email(from)
      Rails.logger.debug "User.find_or_create_by_email(#{from})"
      email = from[/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i]
      creator = self.find_by_email(email) || User.new({:email => email, :password => 'leclerk', :sms_number => "+12145555555"})
      if creator.save
        Rails.logger.debug "creator.save"
        creator
      else
        creator.errors.full_messages.each do |msg|
          Rails.logger.warn msg
        end  
        User.first
      end 
      rescue
        Rails.logger.error "RESCUE in find_or_create_by_email(#{from})" 
        User.first 
    end
  end  
end
