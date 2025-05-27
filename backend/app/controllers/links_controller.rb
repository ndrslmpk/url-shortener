class LinksController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def create
    link = Link.find_or_create_by(original_url: params[:original_url])
    render json: link, status: :created
  end

  def index
    links = Link.order(created_at: :desc)
    render json: links
  end

  def show
    link = Link.find_by!(short_path: params[:id])
    redirect_to link.original_url, allow_other_host: true
  end

  private

  def render_unprocessable_entity(exception)
    render json: { error: exception.record.errors.full_messages.join(', ') }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { error: 'Link not found' }, status: :not_found
  end
end
