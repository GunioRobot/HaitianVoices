# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
unless User.find_by_login('cselmer')
  User.create(  :first_name => 'Chris', 
                :last_name => 'Selmer',
                :login => 'cselmer', 
                :email => 'chris@intridea.com',
                :password => 'selmer123', 
                :password_confirmation => 'selmer123', 
                :twitter => 'cselmer'
              )
end

# adding English only, just so that story/view page doesn't blow up
LANGUAGES = ['English']
LANGUAGES.each do |lang|
  Language.create( :title => lang ) unless Language.find_by_title( lang )
end

