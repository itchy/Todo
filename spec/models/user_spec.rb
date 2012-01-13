require 'spec_helper'

describe User do
  fixtures :users, :tasks
  context "when user exists" do
    fixtures :users
    before(:each) do
      @user = users(:david)
    end
      
    it "should find the user with find_or_create_by_sms_number" do
      user = User.find_or_create_by_sms_number('+12146680255')
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
