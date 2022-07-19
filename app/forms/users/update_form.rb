module Users
  class UpdateForm
    attr_reader :user

    def initialize(user, user_params)
      @user = user
      @user_params = user_params
    end

    def submit
      user.update(@user_params)

      user
    end
  end
end
