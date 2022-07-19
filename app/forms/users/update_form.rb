module Users
  class UpdateForm
    attr_reader :user

    def initialize(user, user_params)
      @user = user
      @user_params = user_params
    end

    def submit
      return user if user.update(@user_params)
    end
  end
end
