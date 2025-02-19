class ApiController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { error_code: 'invalid_params', description: e.message }, status: 422
  end

  rescue_from ActiveRecord::RecordNotFound do |_e|
    render json: { error_code: 'not_found', description: "No se encuentra el recurso con el identificador: #{params[:uuid]}" }, status: 404
  end

  rescue_from ArgumentError do |e|
    render json: { error_code: 'invalid_params', description: e.message }, status: 422
  end
end
