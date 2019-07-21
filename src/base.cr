require "crest"
require "json"
require "./base/**"

module Base
end

client = Base::Client.new(access_token: "e0eb8d71-7c8c-4227-a202-74945161c4de")

user = begin
  client.users.create(
    confirmation: "1234567",
    email: "test@user.com",
    password: "1234567")
rescue
end

begin
  puts client.users.delete(user.try(&.id).to_s)
rescue
end

file = begin
  client.files.create(file: File.open("shard.yml"))
rescue e : Exception
  puts e
end

begin
  puts file.try { |f| client.files.download_url(f.id) }
  puts file.try { |f| client.files.download(f.id) }
rescue e : Base::UnkownError
  puts e.error
end

begin
  puts client.files.delete(file.try(&.id).to_s)
rescue
end

image = begin
  client.images.create(image: File.open("spec/fixtures/test-pattern.jpg"))
rescue e : Exception
  puts e
end

puts image.try { |i|
  client.images.image_url(i.id,
    crop: Base::Crop.new(width: 100, height: 100, top: 0, left: 0),
    resize: Base::Resize.new(width: 100, height: 100),
    format: "jpg",
    quality: 10)
}

begin
  puts client.images.delete(image.try(&.id).to_s)
rescue
end
