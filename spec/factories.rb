# Here be factories.
require 'faker'

Factory.define :story do |f|
  f.title {Faker::Lorem.words(4).join(" ")}
  f.body {Faker::Lorem.paragraph(5)}
  f.about {Faker::Lorem.paragraph(2)}
end

Factory.define :user do |f|
  f.first_name { Faker::Name.first_name }
  f.last_name { Faker::Name.last_name }
  f.login {|u| "#{u.first_name[0,1]}#{u.last_name}".downcase }
  f.email {|u| "#{u.login}@example.com" }
  f.password "password"
  f.password_confirmation {|u| u.password }
end
