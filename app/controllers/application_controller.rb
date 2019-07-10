class ApplicationController < ActionController::Base
    include ApplicationHelper
    
    helper_method :logged_in?

    
end
