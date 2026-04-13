class Api::V1::BaseController < ApplicationControlle
 before_action :authenticate_request

  private

   def authenticate_request
   end
end
