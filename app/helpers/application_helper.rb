module ApplicationHelper
    def logged_in?
        session[:validated]
    end
end
