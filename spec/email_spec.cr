require "./spec_helper"

describe Base do
  context "Listing emails" do
    it "lists emails" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/emails/?page=1&per_page=10")
        .to_return(
          body: {
            items: [{
              created_at:   Time.local.to_rfc2822,
              from_address: "test@user.com",
              to_address:   "test@user.com",
              subject:      "subject",
              html:         "html",
              text:         "text",
              id:           0,
            }],
            metadata: {
              count: 1,
            },
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      list =
        client.emails.list

      list.should be_a(Base::List(Base::Email))
      list.metadata.count.should eq(1)
    end
  end

  context "Sending Emails" do
    it "creates an email log" do
      WebMock
        .stub(:post, "https://api.base-api.io/v1/emails/")
        .to_return(
          body: {
            created_at:   Time.local.to_rfc2822,
            from_address: "test@user.com",
            to_address:   "test@user.com",
            subject:      "subject",
            html:         "html",
            text:         "text",
            id:           0,
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      token =
        client.emails.send(
          from: "test@user.com",
          to: "test@user.com",
          subject: "subject",
          html: "html",
          text: "text")

      token.should be_a(Base::Email)
      token.from_address.should eq("test@user.com")
      token.to_address.should eq("test@user.com")
      token.subject.should eq("subject")
      token.html.should eq("html")
      token.text.should eq("text")
    end
  end
end
