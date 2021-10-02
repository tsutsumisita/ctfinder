# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'securerandom'

# users
10.times do |n|
    User.create!(
        name: SecureRandom.alphanumeric(rand(10..20)), 
        email: SecureRandom.alphanumeric(rand(10..20)) + "@gmail.com", 
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
    Tournament.create!(
        name: SecureRandom.alphanumeric(rand(10..20)), 
        date: Time.parse('2020-01-01 12:00:00')
    )
end

# participants
10.times do |n|
    Participant.create!(
        user_id: User.all.sample(1)[0].id, 
        tournament_id: Tournament.all.sample(1)[0].id
    )
end

# posts
10.times do |n|
    Post.create!(
        participant_id: Participant.all.sample(1)[0].id, 
        content: SecureRandom.alphanumeric(rand(1..140))
    )
end

# likes
10.times do |n|
    liker = User.all.sample(1)[0]
    liked = User.all.sample(1)[0]
    while liker.id == liked.id do
        liked = User.all.sample(1)[0]
    end
    Like.create!(
        liker_id: liker.id,
        liked_id: liked.id
    )
end