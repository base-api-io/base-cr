# Base

Crystal client for the [Base API](https://www.base-api.io) service, with it you
can manage authentication, email sending, files and images of your application.

## Installation

1. Add the dependency to your `shard.yml`:

    dependencies:
      base:
        github: base-api-io/base-cr

2. Run `shards install`

## Usage

1. Sign up on [www.base-api.io0](https://www.base-api.io) and creat an
   applications and copy its access token.

2. Require the shard:

    require "web"

3. Create a client:

    client = Base::Client.new(access_token: "your_access_token")

### Sending email

Using the `emails` endpoint on the client you send emails:

```crystal
# Sending an email
email =
  client.emails.send(
    from: "from@example.com",
    to: "to@example.com",
    subject: "Test Email",
    html: "<b>Html message</b>",
    text: "Text message")
```

### Users

Using the `users` endpoint  on the client you can create / get or delete users:

```crystal
# Create a user with email / password
user =
  client.users.create(
    email: "test@user.com",
    confirmation: "12345",
    password: "12345")

# Get a users details by the id
user =
  client.users.get("user_id")

# Delete a user by id
client.users.delete("user_id")
```

### Files

Using the `files` endpoint  on the client you can create / get / delete or
download files:

```crystal
# Create a file
file =
  client.files.create(file: File.open("/path/to/file"))

# Get a file by id
file =
  client.files.get("file_id")

# Delete a file by id
client.files.delete("file_id")

# Get a download URL to the file
url =
  client.files.download_url("file_id")
```

### Images

Using the `images` endpoint on the client you can create / get / delete or
process images:

```crystal
# Create an image
image =
  client.images.create(image: File.open("/path/to/image"))

# Get a image by id
image =
  client.images.get("image_id")

# Delete a image by id
client.images.delete("image_id")

# Get a link to a prcessed version of the image (crop & resize)
url =
  client.images.image_url(i.id,
    crop: Base::Crop.new(width: 100, height: 100, top: 0, left: 0),
    resize: Base::Resize.new(width: 100, height: 100),
    format: "jpg",
    quality: 10)
```

## Development

This library uses [Crest](https://github.com/mamantoha/crest), you can run the
specs locally with `crystal spec`.

## Contributing

1. Fork it (<https://github.com/base-api-io/base-cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Gusztav Szikszai](https://github.com/gdotdesign) - creator and maintainer
