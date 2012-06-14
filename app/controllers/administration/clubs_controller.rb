module Administration
  class ClubsController < Administration::ContentManagementController
    filter_resource_access

    before_filter :get_region

    def show
      @club = Club.find params[:id]
    end

    def new
      @club = Club.new
    end

    def edit
      @club = Club.find params[:id]
    end

    def create
      @club = @region.clubs.new(params[:club])

      if @club.save
        @club.log_create(current_user.full_name, "#{@club.name} was successfully created")
        redirect_to [:administration,@region], notice: 'Club was successfully created.'
      else
        render action: new
      end
    end

    def update
      @club = Club.find params[:id]

      if @club.update_attributes(params[:club])
        @club.log_update(current_user.full_name, "#{@club.name} was successfully updated")
        redirect_to [:administration,@region], notice: 'Club was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @club = Club.find params[:id]
      @club.destroy
      redirect_to [:administration,@region], notice: "#{@club.name} was destroyed."
    end

    private

    def get_region
      @region = Region.find params[:region_id]
    end
  end
end
