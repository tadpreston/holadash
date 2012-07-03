module Administration
  class UsersController < Administration::ContentManagementController
    filter_resource_access

    # GET /users
    # GET /users.json
    def index
      @users = User.normal

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    end

    # GET /users/1
    # GET /users/1.json
    def show
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end

    # GET /users/new
    # GET /users/new.json
    def new
      @user = User.new(club_ids: params[:club_id])
      @club = Club.find params[:club_id]
      session[:referrer] = request.referrer

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    end

    # GET /users/1/edit
    def edit
      @user = User.find(params[:id])
      session[:referrer] = request.referrer
    end

    # POST /users
    # POST /users.json
    def create
      @user = User.new(params[:user])

      respond_to do |format|
        if @user.save
          @user.log_create(current_user.full_name,"#{@user.full_name} was created")
          redirect_to session[:referrer] || [:administration,@user]
        else
          @club = Club.find params[:user][:club_ids][0]
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /users/1
    # PUT /users/1.json
    def update
      @user = User.find(params[:id])

      respond_to do |format|
        if @user.update_attributes(params[:user])
          @user.log_update(current_user.full_name, "#{@user.full_name} was updated")
          redirect_to session[:referrer] || [:administration,@user]
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to administration_users_url }
        format.json { head :no_content }
      end
    end
  end
end
