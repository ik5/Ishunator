// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require rails.validations

$(function () {

	$('[data-toggleon]').each(function () {

		function getType(el) {
			return (el.attr('type') || el.get(0).nodeName).toLowerCase();
		}

		var self		= $(this),
			targetId 	= self.data('toggleon'),
			target 		= $('#' + targetId),
			targetType	= getType(target),
			types = {
				'checkbox': function (el) {
					el.change(function() {
						self.toggle(el.is(':checked'));
					}).trigger('change');
				},
				'select': function (el) {
					el.bind('keyup change', function() {
						self.toggle(el.val() == self.data('togglevalue'));
					}).trigger('change');
				}
			};

		(types[targetType] || $.noop)(target);
	});

});
