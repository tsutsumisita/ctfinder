# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# users
10.times do |n|
    User.create!(
        name: "sample#{n}", 
        email: "sample#{n}@gmail.com", 
        password: "tintin#{n}", 
        web: [5, [n/2, 1].max].min,
        crypt: [5, [n/2, 1].max].min,
        reversing: [5, [n/2, 1].max].min,
        pwn: [5, [n/2, 1].max].min,
        misc: [5, [n/2, 1].max].min,
        self_introduction: "俺がナンバーワンだ！"
    )
end

# tournaments
10.times do |n|
    Tournament.create!(name: "t#{n}", date: Time.parse('2020-01-01 12:00:00'))
end

# participants
10.times do |n|
    Participant.create!(user_id: User.all[n].id, tournament_id: Tournament.all[n].id)
end