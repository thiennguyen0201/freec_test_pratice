module Users
  class AdminUsersQuery
    def initialize(params)
      @params = params
      @users = User.select(:id, :name, :email).all
    end

    def call
      search_users_by_name(@params[:name])
      search_users_by_email(@params[:email])

      @users.page(@params[:page])
    end

    private

    def search_users_by_name(name)
      return if name.blank?

      @users = @users.by_name(name.strip)
    end

    def search_users_by_email(email)
      return if email.blank?

      @users = @users.by_email(email.strip)
    end
  end
end
