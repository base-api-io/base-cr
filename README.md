# Base

Crystal client for the [Base API](https://www.base-api.io) service, with it you
can manage authentication, email sending, files and images of your application.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     base:
       github: base-api-io/base-cr
       version: 1.0.0
   ```

2. Run `shards install`

## Usage

1. Sign up on [www.base-api.io](https://www.base-api.io) and create an
   application and copy its access token.

2. Require the shard:

   ```crystal
   require "web"
   ```

3. Create a client:

   ```crystal
   client =
     Base::Client.new(access_token: "your_access_token")
   ```

### Sending email

Using the `emails` endpoint on the client you can send emails:

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
# List users
users = client.users.list(page: 1, per_page: 10)
users.items     # The array of users
users.metadata  # The metadata object containing the total count

# Create a user with email / password
user =
  client.users.create(
    email: "test@user.com",
    confirmation: "12345",
    password: "12345",
    custom_data: {
      age: 32
    })

# Get a users details by the id
user =
  client.users.get("user_id")

# Update a users email / custom data
user =
  client.users.update(
    email: "test@user.com",
    id: user.id,
    custom_data: {
      age: 32
    })

# Delete a user by id
user =
  client.users.delete("user_id")
```

### Sessions

Using the `sessions` endpoint on the client you can authenticate a user.

```crystal
# Create a user with email / password
user =
  client.sessions.authenticate(
    email: "test@user.com",
    password: "12345")
```

### Forgot Password Flow

Using the `passwords` endpoint on the client you can perform a forgot password flow.

```crystal
# Create an forgot password token for the user with the given email address.
token =
  client.passwords.forgot_password(email: "test@user.com")

# Using that token set a new password.
user =
  client.passwords.set_password(
    forgot_password_token: token.forgot_password_token,
    confirmation: "123456",
    password: "123456")
```

### Files

Using the `files` endpoint on the client you can create / get / delete or
download files:

```crystal
# List files
files = client.files.list(page: 1, per_page: 10)
files.items     # The array of files
files.metadata  # The metadata object containing the total count

# Create a file
file =
  client.files.create(file: File.open("/path/to/file"))

# Get a file by id
file =
  client.files.get("file_id")

# Delete a file by id
file =
  client.files.delete("file_id")

# Get a download URL to the file by id
url =
  client.files.download_url("file_id")

# Download the file by id into an IO
io =
  client.files.download("file_id")
```

### Images

Using the `images` endpoint on the client you can create / get / delete or
process images:

```crystal
# List images
images = client.images.list(page: 1, per_page: 10)
images.items     # The array of images
images.metadata  # The metadata object containing the total count

# Create an image
image =
  client.images.create(image: File.open("/path/to/image"))

# Get a image by id
image =
  client.images.get("image_id")

# Delete a image by id
image =
  client.images.delete("image_id")

# Get a link to a prcessed version (crop & resize) of the image by id
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
