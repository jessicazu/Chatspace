class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_messages_path(@group.id), notice: 'グループが作成されました'
    else
      flash.now[:aleat] = 'グループ作成に失敗しました'
      render :new
    end
  end

  def edit
    @users = User.all
    @group_users = @group.users
  end

  def update
    if @group.update(group_params)
      redirect_to group_messages_path(@group.id), notice: 'グループを更新しました'
    else
      flash.now[:aleat] = 'グループ更新に失敗しました'
      render :edit
    end
  end


  private
  def group_params
    params.require(:group).permit(:name, {user_ids:[]})
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
