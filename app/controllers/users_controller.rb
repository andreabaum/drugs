class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @consumptions = @user.consumptions.active.sort_by(&:when)
    respond_to do |format|
      format.html
      format.pdf { render pdf: "#{@user.name}_#{Date.today.strftime("%Y%m%d")}" }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name)
    end
end
