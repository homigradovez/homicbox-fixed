SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "Saiga-12"
SWEP.Author 				= "Kalashnikov Concern"
SWEP.Instructions			= "The Saiga-12 is a shotgun manufacturered by the Russian company Kalashnikov Concern. It is either a semi-automatic shotgun by default, or an automatic shotgun when converted. It is patterned on the Kalashnikov series of assault rifles and available in a wide range of configurations. It is named after the Saiga antelope native to Russia."
SWEP.Category 				= "SIB Shotguns"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 12
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12/70 gauge"
SWEP.Primary.Cone = 0.03
SWEP.Primary.Damage = 15
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/mag7/fire01.wav"
SWEP.Primary.FarSound = "weapons/mag7/distant01.wav"
SWEP.Primary.Force = 48
SWEP.ReloadTime = 2.8
SWEP.ShootWait = 0.25
SWEP.NumBullet = 8
SWEP.ReloadSounds = {
    [0.3] = {"weapons/ak47/clipout.wav"},
    [1.3] = {"weapons/ak47/clipin.wav"},
    [1.8] = {"weapons/ak47/bolt.wav"},
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

SWEP.ViewModel				= "models/pwb/weapons/w_saiga_12.mdl"
SWEP.WorldModel				= "models/pwb/weapons/w_saiga_12.mdl"

SWEP.addAng = Angle(0.5,0,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-5,0.8,5.5) -- Sight pos
SWEP.SightAng = Angle(-8,0,0) -- Sight ang


SWEP.Mobility = 1.5
