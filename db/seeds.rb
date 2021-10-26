require "faker"

15.times do
  username = Faker::TvShows::Simpsons.character
  user = User.new(username: username, email: "#{username}@lewagon.com")
  user.save
  post = Post.new(
    name: Faker::TvShows::Simpsons.quote,
    url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    votes: (0..1000).to_a.sample,
    user: user
  )
  post.user = user
  post.save!
end
