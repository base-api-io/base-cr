module Base
  module Endpoints
    # This endpoint contains methods for managing mailing lists.
    class MailingLists < Endpoint
      @path = "mailing_lists"

      # Response struct of the send endpoint
      struct SendResponse
        include JSON::Serializable

        getter failed : Array(String)
        getter sent : Array(String)
      end

      # Lists the mailing lists of a project
      def list(page : Int32 = 1, per_page : Int32 = 10) : List(MailingList)
        request do
          response =
            @resource.get("", params: {
              "per_page" => per_page,
              "page"     => page,
            })

          List(MailingList).from_json(response.body)
        end
      end

      # Sends an email with the given parameters.
      #
      # If there is no sending domain set up all emails will use the
      # `proxy@base-api.io` sender and ignore the given one, also in this case
      # there is a rate limit which is 30 emails in an hour.
      #
      # If there is a sending domain, the sender must match that domain
      # otherwise it will return an error.
      def send(id : String,
               subject : String,
               from : String,
               html : String,
               text : String) : SendResponse
        request do
          response =
            @resource.post("#{id}/send", form: {
              "from"    => from,
              "subject" => subject,
              "html"    => html,
              "text"    => text,
            })

          SendResponse.from_json(response.body)
        end
      end

      # Subscribes an email to the mailing list with the given id.
      def subscribe(id : String, email : String) : MailingList
        request do
          response =
            @resource.post("#{id}/subscribe", form: {
              "email" => email,
            })

          MailingList.from_json(response.body)
        end
      end

      # Unsubscribes an email from the mailing list with the given id.
      def unsubscribe(id : String, email : String) : MailingList
        request do
          response =
            @resource.post("#{id}/unsubscribe", form: {
              "email" => email,
            })

          MailingList.from_json(response.body)
        end
      end

      # Returns the unsubscribe url for the given email of list the given id.
      def unsubscribe_url(id : String, email : String)
        token =
          Base64.encode("#{id}:#{email}")

        "#{@resource.url}unsubscribe?token=#{token}"
      end

      # Returns the metadata of the mailing list with the given ID.
      def get(id) : MailingList
        request do
          response =
            @resource.get id

          MailingList.from_json(response.body)
        end
      end
    end
  end
end
