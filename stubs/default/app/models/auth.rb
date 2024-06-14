class Auth
  attr_reader :name, :session, :user

  def initialize(name, session)
    @name = name
    @session = session
  end

  def get_user
    return @user unless @user.nil?

    id = @session[get_name]

    @user = User.find_by(id: id) unless id.nil?

    @user
  end

  def get_name
    "login_#{@name}_#{Digest::SHA1.hexdigest(self.class.name)}"
  end

  def check?
    not get_user.nil?
  end

  def attempt(credentials = {})
    user = User.authenticate_by(credentials)

    return false if user.nil?

    login user

    true
  end

  def login(user)
    update_session user.id

    set_user user
  end

  def set_user(user)
    @user = user
  end

  def logout
    @session[get_name] = nil
    @user = nil
  end

  private

  def update_session(id)
    @session[get_name] = id
  end
end
