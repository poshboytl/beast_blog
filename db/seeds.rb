# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

terry = Author.create!(
  name: 'Terry Tai',
  email: 'poshboytl@gmail.com',
  avatar: 'http://en.gravatar.com/userimage/2432070/00b9a1609df2774d2fdbc03b49ad8546.jpeg',
  bio: 'Shooting Man',
  password: '111111'
)

chenglu = Author.create!(
  name: 'Chenglu She',
  email: 'smallbanglouis@gmail.com',
  avatar: 'https://avatars1.githubusercontent.com/u/2050207',
  bio: 'bang the world',
  password: '111111'
)

content = "
# Header
## sub

article content

"

# generate posts
50.times do |index|
  terry.posts.create!(
    title: "Article #{index + 1}",
    content: content,
    tag_string: "tag1, tag2, tag3, tag4, tag5, tag6, tag7",
    published: true
  )
end

50.times do |index|
  Author.create!(
      name: 'Chenglu She ' + index.to_s,
      email: 'smallbanglouis' + index.to_s + '@gmail.com',
      avatar: 'https://avatars1.githubusercontent.com/u/2050207',
      bio: 'bang the world',
      password: '111111'
  )
end