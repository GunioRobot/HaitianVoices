# Here be factories.
require 'faker'

Factory.define :story do |f|
  f.title {Faker::Lorem.words(4).join(" ")}
  f.body {Faker::Lorem.paragraph(5)}
  f.about {Faker::Lorem.paragraph(2)}
  f.approved true
end

Factory.define :unreviewed_story, :parent => :story do |s|
  s.approved false
  s.reviewer nil
  s.reviewed_at nil
end

Factory.define :approved_story, :parent => :story do |s|
  s.approved true
  s.reviewer { User.first || Factory(:user) }
  s.reviewed_at { 10.minutes.ago }
end

Factory.define :disapproved_story, :parent => :story do |s|
  s.approved false
  s.reviewer { User.first || Factory(:user) }
  s.reviewed_at { 45.minutes.ago }
end

Factory.define :user do |f|
  f.first_name "Test"
  f.last_name "User"
  f.sequence(:login) {|n| "test_user_#{n}" }
  f.email {|u| "#{u.login}@example.com" }
  f.password "password"
  f.password_confirmation {|u| u.password }
end
