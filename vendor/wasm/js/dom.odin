//+build js wasm32, js wasm64
package wasm_js_interface

foreign import dom_lib "odin_dom"

@(default_calling_convention="contextless")
foreign dom_lib {
	get_element_value_f64    :: proc(id: string) -> f64 ---
	set_element_value        :: proc(id: string, value: f64) ---
}

get_element_value_string :: proc "contextless" (id: string, buf: []byte) -> string {
	@(default_calling_convention="contextless")
	foreign dom_lib {
		@(link_name="get_element_value_string")
		_get_element_value_string :: proc(id: string, buf: []byte) -> int ---
	}
	n := _get_element_value_string(id, buf)
	return string(buf[:n])

}


get_element_min_max :: proc "contextless" (id: string) -> (min, max: f64) {
	@(default_calling_convention="contextless")
	foreign dom_lib {
		@(link_name="get_element_min_max")
		_get_element_min_max :: proc(min_max: ^[2]f64, id: string) ---
	}
	min_max: [2]f64
	_get_element_min_max(&min_max, id)
	return min_max[0], min_max[1]
}


Rect :: struct {
	x, y, width, height: f64,
}

get_bounding_client_rect :: proc "contextless" (id: string) -> (rect: Rect) {
	@(default_calling_convention="contextless")
	foreign dom_lib {
		@(link_name="get_bounding_client_rect")
		_get_bounding_client_rect :: proc(rect: ^Rect, id: string) ---
	}
	_get_bounding_client_rect(&rect, id)
	return
}

get_window_rect :: proc "contextless" () -> (rect: Rect) {
	@(default_calling_convention="contextless")
	foreign dom_lib {
		@(link_name="get_window_rect")
		_get_window_rect :: proc(rect: ^Rect) ---
	}
	_get_window_rect(&rect)
	return
}