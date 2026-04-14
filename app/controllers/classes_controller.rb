class ClassesController < ApplicationController
  def index
     render json: { data: SchoolClassBlueprint.render_as_hash(SchoolClass.all) }
  end
end
