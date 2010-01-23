# Here be factories.
require 'faker'

Factory.define :story do |f|
  f.title {Faker::Lorem.words(4).join(" ")}
  f.body {Faker::Lorem.paragraph(5)}
  f.about {Faker::Lorem.paragraph(2)}
end
