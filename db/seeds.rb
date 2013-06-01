# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(:first_name => 'Scott', :last_name => 'Johnson', :email => '7.scott.j@gmail.com', :sms_number => '+12146680255',  :password => 'leclerk')
u.save