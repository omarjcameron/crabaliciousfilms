# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: 'Max', email: 'max@test.com', password: 'password', trusted: true)

4.times do
  User.create(username: Faker::Name.first_name,
              email: Faker::Internet.safe_email,
              password: Faker::Name.first_name)
end

5.times do
  Category.create(name: Faker::Beer.name)
end

10.times do
  Film.create(title: Faker::Name.name_with_middle,
              category_id: Category.all.sample.id)
end

20.times do
  Review.create(title: Faker::Music.instrument,
                body: Faker::Name.title,
                user_id: User.all.sample.id,
                film_id: Film.all.sample.id)
end

20.times do
  Rating.create(stars: rand(1..5),
                user_id: User.all.sample.id,
                film_id: Film.all.sample.id)
end
