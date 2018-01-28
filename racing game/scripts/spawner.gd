extends Timer

var spawn_items = [
    preload("res://packed/Barrel.tscn"),
    preload("res://packed/Enemy.tscn"),
    preload("res://packed/RoadBlock.tscn")
]

func _ready():
	connect("timeout",self,"_on_timeout")

func _on_timeout():
    var r = rand_range(0,spawn_items.size())
    var item = spawn_items[r].instance()
    var r = rand_range(0,500)
    item.set_pos(Vector2(r, -100))
    get_parent().add_child(item)
