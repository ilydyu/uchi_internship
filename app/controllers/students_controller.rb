class StudentsController < ApplicationController
  def index
    render json: { data: StudentBlueprint.render_as_hash(Student.all) }
  end

  def create
    student = Student.new(student_params)
    raw_token = TokenService.generate_for(student)

    return head :method_not_allowed unless student.save

    response.set_header("X-Auth-Token", raw_token)
    render json: StudentBlueprint.render(student), status: :created
  end

  def destroy
    student = Student.find_by(id: params[:id])

    return head :bad_request if student.nil?

    incoming_raw_token = request.headers["Authorization"]

    unless TokenService.valid?(student.token_digest, incoming_raw_token)
      return render json: { error: "Invalid token" }, status: :unauthorized
    end

    if student.destroy
      head :no_content
    else
      render json: { error: "Unable to delete student" }, status: :unprocessable_entity
    end
  end

  private

   def student_params
      params.permit(:first_name, :last_name, :surname, :class_id, :school_id)
   end
end
