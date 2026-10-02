SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "АКM"
SWEP.Author 				= "Kalashnikov"
SWEP.Instructions			= "AKM - modernized version of the AK, only for the 7.62x39 cartridge, which is in service in Eastern Europe"
SWEP.Category 				= "SIB Rifles"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x39 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 63
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/ak47/fire.wav"
SWEP.Primary.FarSound = "weapons/ak47/distant.wav"
SWEP.Primary.Force = 40
SWEP.ReloadTime = 2.8
SWEP.ShootWait = 0.098
SWEP.ReloadSounds = {
    [0.3] = {"weapons/ak47/clipout.wav"},
    [1.3] = {"weapons/ak47/clipin.wav"},
    [1.8] = {"weapons/ak47/bolt.wav"},
}
SWEP.TwoHands = true
SWEP.Shell = "EjectBrass_762Nato"

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

SWEP.ViewModel				= "models/pwb/weapons/w_akm.mdl"
SWEP.WorldModel				= "models/pwb/weapons/w_akm.mdl"

SWEP.addAng = Angle(-0.02,-0.08,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-5,0.8,5) -- Sight pos
SWEP.SightAng = Angle(-6,0,-2) -- Sight ang

SWEP.Mobility = 1.4

function SWEP:DrawWorldModel()
    self:DrawModel()
end