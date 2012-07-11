class UsersController < ApplicationController
  def search
    users = User.name_search params[:term]

    respond_to do |format| 
      format.json { render json: users.collect { |u| { label: u.full_name, value: u.id } }.to_json }
    end
  end
end
