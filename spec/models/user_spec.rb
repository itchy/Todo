require 'spec_helper'

describe User do
  fixtures :users, :tasks
  context "when testing display name" do
    it "display name should be first last, when user has first && last names" do
      @user = users(:david)
      @user.display_name.should == "David Jones" 
    end 
  
    it "display name should be email address when user does NOT have first && last names, but has email" do
      @user = users(:david)
      @user.stub!(:first_name).and_return(nil)
      @user.display_name.should == "david.jones@email.com"
    end 
  
    it "display name should be number when user does NOT have first && last names NOR email" do
      @user = users(:david)
      @user.stub!(:first_name).and_return(nil)
      @user.stub!(:email).and_return("unknown@sample.com")
      @user.display_name.should == "+12146680255"
    end
  end
  
  context "when user exists" do
    before(:each) do
      @user = users(:david)
    end
      
    it "should find the user with find_or_create_by_sms_number" do
      user = User.find_or_create_by_sms_number('+12146680255')
      user.should == @user
    end 
    
    it "should find the user with find_or_create_by_email" do
      user = User.find_or_create_by_email('David Jones <david.jones@email.com>')
      user.should == @user
    end 
  end  
  
  context "when user doesn't exists" do
    before(:each) do
      @user = users(:david)
    end
      
    it "should create a new user with find_or_create_by_sms_number" do
      user_count = User.all.count
      user = User.find_or_create_by_sms_number('+12146685555')
      user.should be_valid
      user.email.should == "unknown@sample.com"
      user.password.should == 'leclerk'
      User.all.count.should == user_count + 1
    end   
    
    it "should create a new user with find_or_create_by_email" do
      user_count = User.all.count
      user = User.find_or_create_by_email('Jimmer <jimmer@byu.edu>')
      user.should be_valid
      user.email.should == "jimmer@byu.edu"
      user.sms_number.should == "+12145555555"
      user.password.should == 'leclerk'
      User.all.count.should == user_count + 1
    end   
  end
  
  context "body of the task is an email address" do
    before(:each) do
      @user = users(:david)
      @task = tasks(:email)
    end
      
    it "should update the user email address" do
      @user.should_receive(:save)
      @user.create_task(@task.description)
      @user.email.should == @task.description
    end
    
    it "should not create a new task" do
      task_count = Task.all.count
      @user.create_task(@task.description)
      task_count.should == Task.all.count
    end  
  end
end
