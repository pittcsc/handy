module Pagination
  private
    def current_page
      page = params[:page].to_i
      page > 0 ? page : 1
    end
end
