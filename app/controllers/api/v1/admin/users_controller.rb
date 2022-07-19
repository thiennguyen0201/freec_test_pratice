# frozen_string_literal: true

class Api::V1::Admin::UsersController < ApplicationController
  before_action :authenticate_request!
  before_action :set_user, only: [:update, :destroy]

  def index
    authorize User

    users =
      Users::AdminUsersQuery.new(filter_params).call
    render json: { users:, pages: pagination(users) }, status: :ok
  end

  def update
    user_form = Users::UpdateForm.new(@user, update_params)

    if user_form.submit
      render json: { user: user_form.user }, status: :ok
    else
      render json: { error: user_form.user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: { user: @user }, status: :ok
    else
      render json: { error: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def filter_params
    params.permit(:name, :email)
  end

  def update_params
    params.permit(:id, :name, :email)
  end

  def set_user
    @user = User.find_by(id: params[:id])

    authorize @user
  end
end
