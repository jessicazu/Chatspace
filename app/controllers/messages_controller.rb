class MessagesController < ApplicationController

  def index
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @messages = @group.messages
    @message = Message.new

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      respond_to do |format|
        format.html{ redirect_to group_messages_path(@message.group_id), notice: 'メッセージが送信されました' }
        format.json
      end
    else
      redirect_to group_messages_path(@message.group_id), alert: 'メッセージの送信に失敗しました'
    end
  end


  private
  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
