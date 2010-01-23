# Here be factories.
require 'faker'

Factory.define :story do |f|
  f.title {Faker::Lorem.words(4).join(" ")}
  f.body {Faker::Lorem.paragraph(5)}
  f.about {Faker::Lorem.paragraph(2)}
end

Factory.define :user do |f|
  f.first_name "Test"
  f.last_name "User"
  f.sequence(:login) {|n| "test_user_#{n}" }
  f.email {|u| "#{u.login}@example.com" }
  f.password "password"
  f.password_confirmation {|u| u.password }
end
