// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

global.toastr = require("toastr")

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')

toastr.options = {
  // thay đổi nội dung hiển thị trên nút close, vd như "Đóng"
  "closeButton": false,
  
  // thay đổi vị trí của notification
  "positionClass": "toast-bottom-left",
  
  // Các thông báo có hiển thị cùng 1 lúc hay khi cái sau xuất hiện sẽ ẩn cái trước
  "preventDuplicates": false,
  
  // action khi click vào thông báo
  "onclick": null,
  
  // thời gian, hiệu ứng hiển thị và ẩn
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
}