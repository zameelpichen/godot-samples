extends RigidBody2D

var speed = 0
var turn_speed = 0.02
var _max_speed = 500
var _acceleration = 0

var _direction = 0
var _target_rot = 0

var _car_width = 0

func _ready():
	_car_width = get_node("Sprite").get_texture().get_size().x
	connect("body_enter",self,"_on_body_enter")
	set_process(true)
	set_process_input(true)

func _input(event):
    _direction = 0
    _target_rot = 0
    if((event.type==InputEvent.MOUSE_BUTTON) and event.is_pressed() and not event.is_echo()):
        if(event.pos.x < get_pos().x + _car_width/2):
            _target_rot = 5
            _direction = -1
        else:
            _target_rot = -5
            _direction = 1

func _process(delta):
    speed += _acceleration
    speed = min(speed,_max_speed)
    if(speed < _max_speed):
        _acceleration += delta

    var new_pos = get_pos() + Vector2(_direction * turn_speed * speed,0)
    new_pos = Vector2(clamp(new_pos.x,0,640 - _car_width),new_pos.y)
    set_pos(new_pos)
    var rot = lerp(get_rotd(),_target_rot,0.3)
    set_rotd(rot)

func _on_body_enter(other):
	get_node("../Camera2D").shake(0.1,500,10)
	if(other.is_in_group("enemy")):
		other.hit_by_player()
	speed = 0
	set_process(false)


