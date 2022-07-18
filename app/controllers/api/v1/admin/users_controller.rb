# frozen_string_literal: true

class Api::V1::Admin::UsersController < ApplicationController
  before_action :authenticate_request!
  before_action :set_user, only: [:update, :destroy]

  def index
  end

  def update
  end

  def destroy
  end

  private

  def filter_params
    params.require(:q).permit(:name, :email)
  end

  def update_params
    params.permit(:name, :email)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
