class ServiceCharge < ApplicationRecord
  belongs_to :room, dependent: :destroy
  validates :water_price, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: Settings.validations.service_charge.water_price.minimum}
  validates :electricity_price, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: Settings.validations.service_charge.electricity_price.minimum}
  validates :total_price, presence: true, allow_nil: false,
            numericality: {greater_than_or_equal_to: Settings.validations.service_charge.total_price.minimum}
  validates :status, presence: true, allow_nil: false
  validates :month, presence: true, allow_nil: false
  validates :year, presence: true, allow_nil: false
  validates :payer, presence: true, allow_nil: true
  validates :paid_at, presence: true, allow_nil: true

  class << self
    def import_file file
    # file có thể ở dạng file hoặc là path của file đều được xử lý chính xác bởi method open
      spreadsheet = Roo::Spreadsheet.open file
      # lấy cột header (column name)
      header = spreadsheet.row 1
      rows = []
      (2..spreadsheet.last_row).each do |i|
        # lấy ra bản ghi và biến đổi thành hash để có thể tạo record tương ứng
        rows << spreadsheet.row(i)
      end
      import! header, rows
    end
  end
end
