extends TextEdit


func get_total_height():
	scroll_fit_content_height = true
	var y = size.y
	scroll_fit_content_height = false
	return y


func get_container_height():
	return size.y


func scroll():
	var total_height = get_total_height()
	var container_height = get_container_height()
	scroll_vertical = 0
	
