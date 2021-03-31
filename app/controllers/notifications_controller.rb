class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  def count_unread_noti
    # byebug
    @unread_noti = current_user.notifications.where(is_read: false).count
    respond_to do |format|
      format.json { render json: {unread: @unread_noti}}
    end
  end

  def count_total_noti
    # byebug
    @total = current_user.notifications.count
    respond_to do |format|
      format.json { render json: {total: @total}}
    end
  end

  # POST /notifications or /notifications.json
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: "Notification was successfully created." }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1 or /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: "Notification was successfully updated." }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1 or /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: "Notification was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def read_noti
    @noti = Notification.find(params[:id])
    if @noti.is_read == false
      if @noti.update_attribute(:is_read, true)
        respond_to do |format|
          format.json { render json: {}, status: :ok}
        end
      else 
        respond_to do |format|
          format.json { render json: {}, status: :bad_request}
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notification_params
      params.require(:notification).permit(:message)
    end
end
