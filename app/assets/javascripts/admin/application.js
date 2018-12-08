// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require admin-lte
//= require admin/menus
//= require admin/state_codes
//= require admin/products
//= require admin/licenses
//= require moment
//= require bootstrap-datetimepicker
//= require underscore

if (typeof gon !== "undefine" && gon != null) {
  $(function (){
    if (gon.date_format != null && _.include(['new', 'edit', 'create', 'update'], gon.action_name)) {
      $('.datetimepicker').attr('data-date-format', gon.date_format);
      return $('.datetimepicker').datetimepicker();
    }
  });
}

