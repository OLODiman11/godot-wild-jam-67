class_name Resources

const CHARACTER_RES: Dictionary = {
	Constants.CharacterType.MELEE: preload("res://resources/enemies/melee.tres"),
	Constants.CharacterType.GUARD: preload("res://resources/enemies/guard.tres")
}

const WEAPON_RES: Dictionary = {
	Constants.WeaponType.BATON: preload("res://resources/weapons/baton.tres"),
	Constants.WeaponType.PISTOL: preload("res://resources/weapons/pistol.tres"),
	Constants.WeaponType.RIFLE: preload("res://resources/weapons/rifle.tres"),
	Constants.WeaponType.SNIPER_RIFLE: preload("res://resources/weapons/sniper_rifle.tres")
}
