# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'securerandom'

users_size = 50
# users
50.times do |n|
    User.create!(
        name: SecureRandom.alphanumeric(rand(3..10)), 
        email: SecureRandom.alphanumeric(rand(10..20)) + "@gmail.com", 
        password: "tintin#{n}", 
        web: rand(1..5),
        crypto: rand(1..5),
        reversing: rand(1..5),
        pwn: rand(1..5),
        misc: rand(1..5),
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
users = User.all.sample(10)
tournaments = Tournament.all.sample(10)
10.times do |n|
    Participant.create!(
        user: users[n],
        name: users[n].name,
        tournament: tournaments[n]
    )
    if RecentAction.where(user: users[n]).exists?
        RecentAction.find_by(user: users[n]).destroy
    end
    RecentAction.create!(
        action: 2,
        user: users[n],
        tournament: tournaments[n]
    )
end

# posts
participants = Participant.includes(:tournament, :user).sample(10)
10.times do |n|
    Post.create!(
        participant: participants[n], 
        tournament: participants[n].tournament,
        content: SecureRandom.alphanumeric(rand(1..140))
    )
    user = participants[n].user
    if RecentAction.where(user: user).exists?
        RecentAction.find_by(user: user).destroy
    end
    RecentAction.create!(
        action: 2,
        user: user,
        tournament: participants[n].tournament
    )
end

# likes
user_ids = []
20.times do |n|
    user_ids.push(n)
end
users = User.where(id: [user_ids])
10.times do |n|
    Like.create!(
        liker: users[n+1],
        liked: users[n+2]
    )
end
10.times do |n|
    Like.create!(
        liker: users[n+2],
        liked: users[n+1]
    )
end

# matching
10.times do |n|
    Matching.create!(
        user1: users[n+1],
        user2: users[n+2]
    )
end

# direct_message
matching = Matching.all.sample(10)
10.times do |n|
    DirectMessage.create!(
        matching: matching[n],
        sender: [matching[n].user1, matching[n].user2].sample(1)[0],
        content: SecureRandom.alphanumeric(rand(1..140))
    )
end