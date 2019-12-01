module Base
  module Endpoints
    # This endpoint contains methods for forms.
    class Forms < Endpoint
      @path = "forms"

      # Lists the forms of a project
      def list(page : Int32 = 1, per_page : Int32 = 10) : List(Form)
        request do
          response =
            @resource.get("", params: {
              "per_page" => per_page,
              "page"     => page,
            })

          List(Form).from_json(response.body)
        end
      end

      # Creates a form with the given name
      def create(name : String) : Form
        request do
          response =
            @resource.post("", form: {"name" => name})

          Form.from_json(response.body)
        end
      end

      # Returns the form with the given ID.
      def get(id : String) : Form
        request do
          response =
            @resource.get id

          Form.from_json(response.body)
        end
      end

      # Deletes the form with the given ID.
      def delete(id : String) : Form
        request do
          response =
            @resource.delete id

          Form.from_json(response.body)
        end
      end

      # Submits a new submission for the form with the given ID.
      def submit(id : String, form) : FormSubmission
        request do
          response =
            @resource.post("#{id}/submit", form: form)

          FormSubmission.from_json(response.body)
        end
      end

      # Returns the submission for the form with the given ID.
      def submissions(id : String,
                      page : Int32 = 1,
                      per_page : Int32 = 10) : List(FormSubmission)
        request do
          response =
            @resource.get("#{id}/submissions", params: {
              "per_page" => per_page,
              "page"     => page,
            })

          List(FormSubmission).from_json(response.body)
        end
      end

      # Returns the form submission with the given ID of the form with the given ID.
      def get_submission(id : String, submission_id : String) : FormSubmission
        request do
          response =
            @resource.get "#{id}/submissions/#{submission_id}"

          FormSubmission.from_json(response.body)
        end
      end

      # Submits a new submission for the form with the given ID.
      def update_submission(id : String, submission_id : String, form) : FormSubmission
        request do
          response =
            @resource.put("#{id}/submit/#{submission_id}", form: form)

          FormSubmission.from_json(response.body)
        end
      end

      # Deletes the form submission with the given ID of the form with the given ID.
      def delete_submission(id : String, submission_id : String) : FormSubmission
        request do
          response =
            @resource.delete "#{id}/submissions/#{submission_id}"

          FormSubmission.from_json(response.body)
        end
      end
    end
  end
end
