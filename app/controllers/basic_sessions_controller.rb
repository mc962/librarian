class BasicSessionsController < ApplicationController
    # Very basic method to handle simple authentication based on an API key in order to prevent easy spamming
    # Upon successful authentication, user will receive a temporary value in the Rails session cookie indicating they are logged in, and have 
    # access to tasks that require authentication. The goal is to replace this with something more robust like Devise, or something that
    # at least involves the ability for multi-user credentials, as if the API key is compromised, then it will need to be replaced which 
    # may log out all users relying on this key. In order to 'log out', the cookie must either be deleted from the browser, 
    # or all session cookies must be invalidated.
    def create
        if params[:basic_sessions][:password] == Rails.application.credentials.simple_authentication_key
            session[:validated] = true
            flash[:success] = 'Validated!'
        else
            flash[:danger] = 'Problem validating...'
        end

        redirect_to codelets_path
    end
end
