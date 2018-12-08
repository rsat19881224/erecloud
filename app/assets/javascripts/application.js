//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require admin-lte
//= require moment
//= require bootstrap-datetimepicker
//= require underscore
//= require jquery_nested_form
//= require_self
//= require search_modal 
//= require simplecalendarjp
//= require recording_institution
//= require common_form

(function() {
  if (typeof gon !== "undefine" && gon != null) {
    $(function(){
      if (gon.date_format != null && _.include(['new', 'edit'], gon.action_name)) {
        $('.datetimepicker').attr('data-date-format', gon.date_format);
	  return $('.datetimepicker').datetimepicker();
      }
    });
  }

  window.erecloud = {exports: {}};

  window.erecloud_export = function (name, obj) {
    this.erecloud.exports[name] = obj;
    return this;
  };

  window.erecloud_require = function (name) {
    if (this.erecloud.exports.hasOwnProperty(name)) {
      return this.erecloud.exports[name];
    }
      return null;
  };

  window.erecloud_require_module = window.erecloud_require;

  window.erecloud_export_module = function(module_name, property_name, property_obj) {
    var module = {};
    if (this.erecloud.exports.hasOwnProperty(module_name)) {
      module = window.erecloud_require(module_name);
      module[property_name] = property_obj;
    } else {
      module[property_name] = property_obj;
      window.erecloud.exports[module_name] = module;
    }
    return module;
  };
}());
