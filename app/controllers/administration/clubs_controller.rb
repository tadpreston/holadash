module Administration
  class ClubsController < Administration::ContentManagementController
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
        redirect_to [:administration,@region], notice: 'Club was successfully created.'
      else
        render action: new
      end
    end

    def update
      @club = Club.find params[:id])

      if @club.update_attributes(params[:club])
        redirect_to [:administration,@region], notice: 'Club was successfully updated.'
      else
        render action: "edit"
      end
    end

    private

    def get_region
      @region = Region.find params[:region_id]
    end
  end
end
