SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "Franchi SPAS-12"
SWEP.Author 				= "Franchi"
SWEP.Instructions			= "The Franchi SPAS-12 is a combat shotgun manufactured by Italian firearms company Franchi from 1979 to 2000. The SPAS-12 is a dual-mode shotgun, adjustable for semi-automatic or pump-action operation. The SPAS-12 was sold to military and police users worldwide, as well as on the civilian market."
SWEP.Category 				= "SIB Shotguns"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12/70 gauge"
SWEP.Primary.Cone = 0.01
SWEP.Primary.Damage = 30
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/nova/fire.wav"
SWEP.Primary.FarSound = "weapons/nova/distant.wav"
SWEP.Primary.Force = 25
SWEP.ReloadTime = 3
SWEP.ShootWait = 0.5
SWEP.NumBullet = 8
SWEP.ReloadSounds = {
    [0.3] = {"weapons/nova/insertshell01.wav"},
    [0.6] = {"weapons/nova/insertshell02.wav"},
    [0.9] = {"weapons/nova/insertshell03.wav"},
    [1.2] = {"weapons/nova/insertshell04.wav"},
    [1.5] = {"weapons/nova/insertshell01.wav"},
    [1.8] = {"weapons/nova/insertshell03.wav"},
    [2.1] = {"weapons/nova/insertshell02.wav"},
    [2.4] = {"weapons/nova/insertshell04.wav"},
    [2.7] = {"weapons/nova/pump.wav"},
}
SWEP.TwoHands = true
SWEP.Shell = "EjectBrass_12Gauge"

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

SWEP.ViewModel				= "models/pwb/weapons/w_spas_12.mdl"
SWEP.WorldModel				= "models/pwb/weapons/w_spas_12.mdl"

SWEP.addAng = Angle(-0.5,0,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-5,0.88,3.6) -- Sight pos
SWEP.SightAng = Angle(-8,0,0) -- Sight ang


SWEP.Mobility = 1.5
