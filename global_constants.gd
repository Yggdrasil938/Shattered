extends Node
## Global Constants File
## Contains constants and enums that are used multiple times throughout scripts.
## Allows for cleaner scripts

# Preloads references to all enemy types
const ENEMY_DECK_MASTER: Dictionary = {
	"chip": preload("res://Enemy Chips/Melee/Basic/Chip.tscn"), 
	"fast_chip": preload("res://Enemy Chips/Melee/Fast/fast_chip.tscn"), 
	"chip_angle": preload("res://Enemy Chips/Melee/Angled/chip_angle.tscn"), 
	"chip_shoot": preload("res://Enemy Chips/Ranged/Basic/chip_shoot.tscn"),
}

# Preloads node references for mechanical layers to instantiate
const PANE_PAINTER = preload("res://Combat Mechanics/Mechanical Layers/Painter/pane_painter.tscn")
const CHIP_SPAWNER = preload("res://Combat Mechanics/Mechanical Layers/Spawner/chip_spawner.tscn")
const PLAYER = preload("res://Combat Mechanics/Player/player.tscn")
