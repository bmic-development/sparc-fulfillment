$("#modal_area").html("<%= escape_javascript(render(partial: @report_type, locals: { title: @title, report_type: @report_type })) %>")
$("#modal_place").modal('show')
$('#start_date').datetimepicker(format: 'MM-DD-YYYY')
$('#end_date').datetimepicker(format: 'MM-DD-YYYY')
$(".modal-content .selectpicker").selectpicker()

# $ ->
# 	$('#institution_select').on 'change', ->
# 		institution_id = $(this).val()
# 		console.log($("#provider_select").data('providers'))
# 		$('#provider_select').closest('.form-group').show()
	# $('#institution_select').on 'change', ->
	# 	console.log("institution selected")
	# 	data = {institution_id: $('#institution_select').val()}
	# 	console.log(data)
	# 	$.ajax
	# 		type: 'PUT'
	# 		url: '/reports/update_providers'
	# 		data: data
	# 		dataType: "script"
	# 	console.log()

	# $('#provider_select').on 'change', ->
	# 	console.log("provider selected")
	# 	data = {provider_id: $('#provider_select').val()}
	# 	console.log(data)
	# 	$.ajax
	# 		url: '/reports/update_programs'
	# 		data: data
	# 		dataType: "script"

