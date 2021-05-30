class Student < ApplicationRecord
  # before_update :update_number_student, :if => :room_id?
  # after_update :update_number_student,:if => :room_id?
  attr_accessor :remember_token, :reset_token
  belongs_to :room
  has_one :student_profile, dependent: :destroy
  accepts_nested_attributes_for :student_profile, allow_destroy: true
  has_many :form_requests, dependent: :destroy
  has_many :complaint_reports, dependent: :destroy
  has_many :facility_reports, dependent: :destroy

  has_many :passive_notifications, class_name: Notification.name,
    foreign_key: :sender_id,
    dependent: :destroy
  has_many :active_notifications, class_name: Notification.name,
    foreign_key: :receiver_id,
    dependent: :destroy
  # has_many :notifications, through: :passive_notifications,
  #   source: :receiver, source_type: Student.name
  # has_many :sent_notifications, through: :active_notifications,
  #   source: :sender, source_type: Student.name
  has_many :notifications, as: :receiver
  has_many :sent_notifications, as: :sender
  # student_id_number 8 - 12
  validates :student_id_number, presence: true, allow_nil: false,
            length: {
              minimum: Settings.validations.student.student_id_number.min_length, 
              maximum: Settings.validations.student.student_id_number.max_length,
              too_short: "ma hoc vien qua ngan",
              too_long: "ma hoc vien qua dai"
            },
            uniqueness: {
              # object = person object being validated
              # data = { model: "Person", attribute: "Username", value: <username> }
              message: ->(object, data) do
                "Hey u! #{data[:value]} da duoc tao!!"
              end
            }
  validates :name, presence: true, allow_nil: false,
            length: {
              maximum: Settings.validations.student.name.max_length,
              too_long: "Ten qua dai!!"
            }
  validates :check_in_date, presence: true, allow_nil: true
  validates :check_out_date, presence: true, allow_nil: true

  has_secure_password

  def Student.new_token
    SecureRandom.urlsafe_base64
  end

  after_create do 
    if self.room.id
      @room = Room.find(self.room.id)
      @room.update(number_student: @room.number_student + 1)
      if @room.number_student == 0
        @room.update(status: "PENDING") 
      elsif @room.number_student == @room.max_number_student
        @room.update(status: "FULL")
      elsif @room.number_student < @room.max_number_student
        @room.update(status: "UNFILLED")
      end
    end
    length = self.name.split(" ").length
    self.update(first_name: self.name.split(" ")[length - 1], last_name: self.name.split(" ")[0])
  end

  after_update do
    #room
    room_after = Room.find(self.room.id)
    room_after.update(number_student: room_after.students.count)
    if room_after.number_student == 0
      room_after.update(status: "PENDING") 
    elsif room_after.number_student == room_after.max_number_student
      room_after.update(status: "FULL")
    elsif room_after.number_student < room_after.max_number_student
      room_after.update(status: "UNFILLED")
    end
    room_before = Room.find(self.room_id_before_last_save)
    room_before.update(number_student: room_before.students.count)
    if room_before.number_student == 0
      room_before.update(status: "PENDING")
    elsif room_before.number_student == room_before.max_number_student
      room_before.update(status: "FULL")
    elsif room_before.number_student < room_before.max_number_student 
      room_before.update(status: "UNFILLED")
    end

  end

  after_destroy do
    room = Room.find(self.room_id)
    room.update(number_student: room.students.count)
    if room.number_student == 0
      room.update(status: "PENDING")
    elsif room.number_student == room.max_number_student
      room.update(status: "FULL")
    elsif room.number_student < room.max_number_student
      room.update(status: "UNFILLED")
    end
  end
  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def import_file file
      # file có thể ở dạng file hoặc là path của file đều được xử lý chính xác bởi method open
      spreadsheet = Roo::Spreadsheet.open file
      # lấy cột header (column name)
      header = spreadsheet.row 1
      (2..spreadsheet.last_row).each do |i|
        # lấy ra bản ghi và biến đổi thành hash để có thể tạo record tương ứng
        data = [header, spreadsheet.row(i)].transpose.to_h
        # byebug
        student = Student.create(student_id_number: data["student_id_number"].to_s, name: data["name"], channel: Time.now.to_i, password: data["student_id_number"].to_s)
        StudentProfile.create!(email: data["email"], student_id: student.id, name: data["name"])
      end
    end
  end
  def remember
    self.remember_token = Student.new_token
    update_attribute(:remember_digest, Student.digest(remember_token))
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = Student.new_token
    update reset_digest: Student.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

end
