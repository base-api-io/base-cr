require "./spec_helper"

describe Base do
  context "Mailing Lists" do
    context "Listing mailing lists" do
      it "lists mailing lists" do
        WebMock
          .stub(:get, "https://api.base-api.io/v1/mailing_lists/?page=1&per_page=10")
          .to_return(
            body: {
              items: [{
                created_at:               Time.now.to_rfc2822,
                emails:                   ["test@user.com"],
                name:                     "Test",
                unsubscribe_redirect_url: "",
                id:                       "0",
              }],
              metadata: {
                count: 1,
              },
            }.to_json)

        client =
          Base::Client.new(access_token: "access_token")

        list =
          client.mailing_lists.list

        list.should be_a(Base::List(Base::MailingList))
        list.metadata.count.should eq(1)
      end
    end

    context "Subscribing to a mailing list" do
      it "subscribes the given email" do
        WebMock
          .stub(:post, "https://api.base-api.io/v1/mailing_lists/0/subscribe")
          .to_return(
            body: {
              created_at:               Time.now.to_rfc2822,
              emails:                   ["test@user.com"],
              name:                     "Test",
              unsubscribe_redirect_url: "",
              id:                       "0",
            }.to_json)

        client =
          Base::Client.new(access_token: "access_token")

        list =
          client.mailing_lists.subscribe(
            id: "0",
            email: "test@user.com")

        list.should be_a(Base::MailingList)
        list.emails.should eq(["test@user.com"])
        list.name.should eq("Test")
        list.id.should eq("0")
      end
    end

    context "Unsubscribing from a mailing list" do
      it "unsubscribes the given email" do
        WebMock
          .stub(:post, "https://api.base-api.io/v1/mailing_lists/0/unsubscribe")
          .to_return(
            body: {
              created_at:               Time.now.to_rfc2822,
              emails:                   ["test@user.com"],
              name:                     "Test",
              unsubscribe_redirect_url: "",
              id:                       "0",
            }.to_json)

        client =
          Base::Client.new(access_token: "access_token")

        list =
          client.mailing_lists.unsubscribe(
            id: "0",
            email: "test@user.com")

        list.should be_a(Base::MailingList)
        list.emails.should eq(["test@user.com"])
        list.name.should eq("Test")
        list.id.should eq("0")
      end
    end

    context "Getting a public unsubscribe URL" do
      it "returns the url with the token" do
        client =
          Base::Client.new(access_token: "access_token")

        url =
          client.mailing_lists.unsubscribe_url(
            id: "0",
            email: "test@user.com")

        token =
          Base64.encode("0:test@user.com")

        url.should eq("https://api.base-api.io/v1/mailing_lists/unsubscribe?token=#{token}")
      end
    end

    context "Sending emails" do
      it "sends emails" do
        WebMock
          .stub(:post, "https://api.base-api.io/v1/mailing_lists/0/send")
          .to_return(
            body: {
              failed: ["test2@user.com"],
              sent:   ["test@user.com"],
            }.to_json)

        client =
          Base::Client.new(access_token: "access_token")

        response =
          client.mailing_lists.send(
            id: "0",
            from: "test@user.com",
            subject: "subject",
            html: "html",
            text: "text")

        response.should be_a(Base::Endpoints::MailingLists::SendResponse)
        response.failed.should eq(["test2@user.com"])
        response.sent.should eq(["test@user.com"])
      end
    end

    context "Get mailing list" do
      it "gets a mailing lists details" do
        WebMock
          .stub(:get, "https://api.base-api.io/v1/mailing_lists/list_id")
          .to_return(
            body: {
              created_at:               Time.now.to_rfc2822,
              emails:                   ["test@user.com"],
              name:                     "Test",
              unsubscribe_redirect_url: "",
              id:                       "id",
            }.to_json)

        client =
          Base::Client.new(access_token: "access_token")

        list =
          client.mailing_lists.get("list_id")

        list.should be_a(Base::MailingList)
        list.unsubscribe_redirect_url.should eq("")
        list.emails.should eq(["test@user.com"])
        list.name.should eq("Test")
        list.id.should eq("id")
      end
    end
  end
end
