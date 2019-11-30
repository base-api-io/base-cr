require "./spec_helper"

describe Base do
  context "Listing forms" do
    it "lists forms" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/forms/?page=1&per_page=10")
        .to_return(
          body: {
            items: [{
              created_at: Time.local.to_rfc2822,
              name:       "Test",
              id:         "id",
            }],
            metadata: {
              count: 1,
            },
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      list =
        client.forms.list

      list.should be_a(Base::List(Base::Form))
      list.metadata.count.should eq(1)
    end
  end

  context "Create a from" do
    it "creates a form" do
      WebMock
        .stub(:post, "https://api.base-api.io/v1/forms/")
        .to_return(
          body: {
            created_at: Time.local.to_rfc2822,
            name:       "Test",
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      form =
        client.forms.create(name: "Test")

      form.should be_a(Base::Form)
      form.name.should eq("Test")
      form.id.should eq("id")
    end
  end

  context "Get a form" do
    it "gets a forms" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/forms/form_id")
        .to_return(
          body: {
            created_at: Time.local.to_rfc2822,
            name:       "Test",
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      form =
        client.forms.get("form_id")

      form.should be_a(Base::Form)
      form.name.should eq("Test")
      form.id.should eq("id")
    end
  end

  context "Delete a form" do
    it "deletes a form" do
      WebMock
        .stub(:delete, "https://api.base-api.io/v1/forms/form_id")
        .to_return(
          body: {
            created_at: Time.local.to_rfc2822,
            name:       "Test",
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      form =
        client.forms.delete("form_id")

      form.should be_a(Base::Form)
      form.name.should eq("Test")
      form.id.should eq("id")
    end
  end

  context "Submit a submission" do
    it "creates a submission" do
      WebMock
        .stub(:post, "https://api.base-api.io/v1/forms/form_id/submit")
        .to_return(
          body: {
            created_at: Time.local.to_rfc2822,
            files:      [] of String,
            fields:     nil,
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      submission =
        client.forms.submit(id: "form_id", form: {"key" => "value"})

      submission.should be_a(Base::FormSubmission)
      submission.files.should eq([] of String)
      submission.fields.should eq(nil)
      submission.id.should eq("id")
    end
  end

  context "Listing submissions" do
    it "lists form submissions" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/forms/form_id/submissions?page=1&per_page=10")
        .to_return(
          body: {
            items: [{
              created_at: Time.local.to_rfc2822,
              files:      [] of String,
              fields:     nil,
              id:         "id",
            }],
            metadata: {
              count: 1,
            },
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      list =
        client.forms.submissions(id: "form_id")

      list.should be_a(Base::List(Base::FormSubmission))
      list.metadata.count.should eq(1)
    end
  end

  context "Get a form submission" do
    it "gets a form submission" do
      WebMock
        .stub(:get, "https://api.base-api.io/v1/forms/form_id/submissions/id")
        .to_return(
          body: {
            created_at: Time.local.to_rfc2822,
            files:      [] of String,
            fields:     nil,
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      submission =
        client.forms.get_submission("form_id", "id")

      submission.should be_a(Base::FormSubmission)
      submission.files.should eq([] of String)
      submission.fields.should eq(nil)
      submission.id.should eq("id")
    end
  end

  context "Update a submission" do
    it "updates a submission" do
      WebMock
        .stub(:put, "https://api.base-api.io/v1/forms/form_id/submit/submission_id")
        .to_return(
          body: {
            created_at: Time.local.to_rfc2822,
            files:      [] of String,
            fields:     nil,
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      submission =
        client
          .forms
          .update_submission(
            id: "submission_id",
            form_id: "form_id",
            form: {"key" => "value"})

      submission.should be_a(Base::FormSubmission)
      submission.files.should eq([] of String)
      submission.fields.should eq(nil)
      submission.id.should eq("id")
    end
  end

  context "Delete a form" do
    it "deletes a form" do
      WebMock
        .stub(:delete, "https://api.base-api.io/v1/forms/form_id/submissions/id")
        .to_return(
          body: {
            created_at: Time.local.to_rfc2822,
            files:      [] of String,
            fields:     nil,
            id:         "id",
          }.to_json)

      client =
        Base::Client.new(access_token: "access_token")

      submission =
        client.forms.delete_submission("form_id", "id")

      submission.should be_a(Base::FormSubmission)
      submission.files.should eq([] of String)
      submission.fields.should eq(nil)
      submission.id.should eq("id")
    end
  end
end
