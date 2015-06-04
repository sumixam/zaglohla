class Authentication::SessionsController < Devise::SessionsController

  def new
    if request.xhr?
      super
    else
      redirect_to root_path
    end
  end
end
