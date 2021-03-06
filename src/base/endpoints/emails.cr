module Base
  module Endpoints
    # This endpoint contains methods for sending emails.
    class Emails < Endpoint
      @path = "emails"

      # Sends an email with the given parameters.
      #
      # If there is no sending domain set up all emails will use the
      # `proxy@base-api.io` sender and ignore the given one, also in this case
      # there is a rate limit which is 30 emails in an hour.
      #
      # If there is a sending domain, the sender must match that domain
      # otherwise it will return an error.
      def send(subject : String,
               from : String,
               to : String,
               html : String | Nil = nil,
               text : String | Nil = nil) : Email
        request do
          response =
            @resource.post("", form: {
              "from"    => from,
              "to"      => to,
              "subject" => subject,
              "html"    => html,
              "text"    => text,
            })

          Email.from_json(response.body)
        end
      end

      # Lists sent emails of a project
      def list(page : Int32 = 1, per_page : Int32 = 10) : List(Email)
        request do
          response =
            @resource.get("", params: {
              "per_page" => per_page,
              "page"     => page,
            })

          List(Email).from_json(response.body)
        end
      end
    end
  end
end
