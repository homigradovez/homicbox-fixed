SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "Remington 870"
SWEP.Author 				= "Remington Arms Company"
SWEP.Instructions			= "The Remington Model 870 is a pump-action shotgun manufactured by Remington Arms Company, LLC. It is widely used by the public for shooting sports, hunting and self-defense, as well as by law enforcement and military organizations worldwide."
SWEP.Category 				= "SIB Shotguns"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12/70 gauge"
SWEP.Primary.Cone = 0.01
SWEP.Primary.Damage = 30
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/sawedoff/fire.wav"
SWEP.Primary.FarSound = "weapons/sawedoff/distant.wav"
SWEP.Primary.Force = 35
SWEP.ReloadTime = 2.7
SWEP.ShootWait = 1
SWEP.NumBullet = 8
SWEP.ReloadSounds = {
    [0.2] = {"weapons/sawedoff/insertshell03.wav"},
    [0.8] = {"weapons/sawedoff/insertshell03.wav"},
    [1.5] = {"weapons/sawedoff/insertshell03.wav"},
    [1.8] = {"weapons/sawedoff/insertshell03.wav"},
    [2.1] = {"weapons/sawedoff/insertshell03.wav"},
    [2.6] = {"weapons/sawedoff/insertshell03.wav"},
    [2.7] = {"weapons/sawedoff/pump.wav"},
}
SWEP.TwoHands = true
SWEP.Shell = "EjectBrass_12Gauge"
SWEP.ShellRotate = false

SWEP.Pumpsound = "weapons/sawedoff/pump.wav"
SWEP.Pump = true

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

------------------------------------------

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.HoldType = "ar2"

------------------------------------------

SWEP.Slot					= 2
SWEP.SlotPos				= 0
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false

SWEP.ViewModel				= "models/district/w_shot_r870.mdl"
SWEP.WorldModel				= "models/district/w_shot_r870.mdl"

SWEP.addAng = Angle(-0.5,0,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-5,0.77,3.6) -- Sight pos
SWEP.SightAng = Angle(-8,0,0) -- Sight ang


SWEP.Mobility = 1.5
