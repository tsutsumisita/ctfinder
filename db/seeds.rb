# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'securerandom'

users_size = 70
# users
50.times do |n|
    User.create!(
        name: SecureRandom.alphanumeric(rand(10..20)), 
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
participants = Participant.all.sample(10)
10.times do |n|
    Post.create!(
        participant: participants[n], 
        tournament: participants[n].tournament,
        content: SecureRandom.alphanumeric(rand(1..140))
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

# ids = []
# while ids.size < 10 do
#     x = (rand(1..users_size+1), rand(1..users_size+1))
#     ids.push(x) unless ids.include?(x)
# end

# likes
10.times do |n|
    liker = User.all.sample(1)[0]
    liked = User.all.sample(1)[0]
    while liker == liked do
        liked = User.all.sample(1)[0]
    end
    Like.create!(
        liker: liker,
        liked: liked
    )
end

# matching
10.times do |n|
    user1 = User.all.sample(1)[0]
    user2 = User.all.sample(1)[0]
    while user1 == user2 do
        user2 = User.all.sample(1)[0]
    end
    Matching.create!(
        user1: user1,
        user2: user2
    )
end

# direct_message
10.times do |n|
    matching = Matching.all.sample(1)[0]
    DirectMessage.create!(
        matching: matching,
        sender: [matching.user1, matching.user2].sample(1)[0],
        content: SecureRandom.alphanumeric(rand(1..140))
    )
end

# post_action
post_all = Post.all
posts = []
ids = []
post_all.each do |p|
    unless ids.include?(p.participant.user.id)
        posts.push(p)
        ids.push(p.participant.user.id)
        break ids.size == 5
    end
end

posts.each do |p|
    user = p.participant.user
    PostAction.create!(
        post: p,
	    user: user
    )
    if RecentAction.where(user: user).exists?
        RecentAction.find_by(user: user).destroy
    end
    RecentAction.create!(
        action: 1,
        user: user,
        tournament: p.tournament
    )
end

# participant_action
participant_all = Participant.all
participants = []
ids = []
participant_all.each do |p|
    unless ids.include?(p.user.id)
        participants.push(p)
	ids.push(p.user.id)
	break ids.size == 5
    end
end

participants.each do |p|
    ParticipantAction.create!(
        participant: p,
	    user: p.user
    )
end