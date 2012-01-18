class PublicController < ApplicationController
  # MixIn ActionView::Helpers::TextHelper for truncate 
  include ActionView::Helpers::TextHelper
  # before_filter :authenticate
  
  def index
  end
  
  
  # should respond to post
  def sms
    account_sid = params[:AccountSid]
    body = params[:Body]
    from = params[:From]
    from_zip =  params[:FromZip]
    if from && body && # account_sid == TWILIO_ACCOUNT_SID
      # sms = TwilioNet.new()
      # sms.send_sms('2146680255', truncate("FROM:#{from}  BODY:#{body}", :length => 159) )
      # render :layout => 'empty', :template => 'public/sms'  
      creator = User.find_or_create_by_sms_number(from)
      creator.create_task(body)
      unless creator.valid?
        Rails.logger.error creator.message
        sms = TwilioNet.new()
        sms.send_sms(from, truncate(creator.message, :length => 159) )
      end
      render :text => "Task created."  
    else
      raise error  
    end 
  rescue
    render :text => "Invalid Params #{params.inspect}"
  end 
  
  def email
    Rails.logger.info params.inspect
    creator = User.find_or_create_by_email(params[:from])
    creator.create_task(body)
    unless creator.valid?
      Rails.logger.error creator.message
      # sms = TwilioNet.new()
      # sms.send_sms(from, truncate(creator.message, :length => 159) )
    end
    render :text => "Task created."
  end 
end
