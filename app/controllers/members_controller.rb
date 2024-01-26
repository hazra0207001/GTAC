class MembersController < ApplicationController
  before_action :set_member, only: [:edit,:update,:show,:destroy]
  def index
    @members = Member.all
  end
  def new
    @member = Member.new
  end
  def create
    @member =Member.new(member_params)

    if @member.save
      redirect_to members_path, notice: " #{@member.name} Created successfully"
    else

      render :new
    end
  end
  def edit

  end
  def update
    if @member.update(member_params)
      redirect_to members_path, notice: " Your  #{@member.name} updated successfully"
    else
      render :edit
    end
  end
  def show
  end

  def destroy
    if @member.destroy
      redirect_to members_path, notice: "#{@member.name} Deleted successfully"
    end
  end


  private
    def member_params
      params.require(:member).permit(:name, :father_name, :mother_name, :flat_no, :nid_no)
    end
    def set_member
      @member =Member.find(params[:id])
      rescue ActiveRecord::RecordNotFound => error
      redirect_to products_path, notice: error

    end
end
