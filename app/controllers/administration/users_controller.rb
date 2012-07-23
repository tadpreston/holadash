module Administration
  class UsersController < Administration::ContentManagementController
    filter_resource_access

    def index
      @users = User.normal
    end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new(club_ids: params[:club_id])
      @club = Club.find params[:club_id] if params[:club_id]
      session[:referrer] = request.referrer
    end

    def edit
      @user = User.find(params[:id])
      session[:referrer] = request.referrer
    end

    def create
      @user = User.new(params[:user])
      if @user.save
        @user.log_create(current_user.full_name,"#{@user.full_name} was created")
        redirect_url = session[:referrer]
        session[:referrer] = nil
        redirect_to redirect_url, notice: "#{@user.full_name} was successfully created!"
      else
        @club = Club.find params[:user][:club_ids][0]
        render action: 'new'
      end
    end

    def update
      @user = User.find(params[:id])

      if @user.update_attributes(params[:user])
        @user.log_update(current_user.full_name, "#{@user.full_name} was updated")
        redirect_url = session[:referrer]
        session[:referrer] = nil
        redirect_to redirect_url, notice: "#{@user.full_name} was successfully updated!"
      else
        render action: "edit"
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy

      redirect_to request.referrer, notice: "#{@user.full_name} was successfully deleted!"
    end
  end
end
