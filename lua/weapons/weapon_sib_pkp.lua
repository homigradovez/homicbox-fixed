SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "PKM"
SWEP.Author 				= "Kalashnikov"
SWEP.Instructions			= "A belt-fed general-purpose machine gun, chambered for the 7.62×54mm rimmed cartridge."
SWEP.Category 				= "SIB Machine Guns"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 150
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x39 mm"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 70
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/tfa_ins2/ak103/ak103_fp.wav"
SWEP.Primary.FarSound = "weapons/m249/distant.wav"
SWEP.Primary.Force = 33
SWEP.ReloadTime = 7
SWEP.ShootWait = 0.07
SWEP.ReloadSounds = {
    [0.1] = {"pwb/weapons/pkm/coverup.wav"},
    [0.9] = {"pwb/weapons/pkm/boxout.wav"},
    [1.6] = {"pwb/weapons/pkm/draw.wav"},
    [2.3] = {"pwb/weapons/pkm/boxin.wav"},
    [3] = {"pwb/weapons/pkm/chain.wav"},
    [3.4] = {"pwb/weapons/pkm/coverdown.wav"},
    [4] = {"pwb/weapons/pkm/coversmack.wav"},
    [5] = {"pwb/weapons/pkm/bolt.wav"},
}
SWEP.TwoHands = true
SWEP.Shell = "EjectBrass_556"
SWEP.ShellRotate = false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

------------------------------------------

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.HoldType = "smg"

------------------------------------------

SWEP.Slot					= 2
SWEP.SlotPos				= 0
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false

SWEP.ViewModel				= "models/pwb/weapons/w_pkm.mdl"
SWEP.WorldModel				= "models/pwb/weapons/w_pkm.mdl"

SWEP.addAng = Angle(0,-0.5,0) -- Barrel pos adjust
SWEP.addPos = Vector(0,0,0) -- Barrel ang adjust
SWEP.SightPos = Vector(-7,0.8,4.7) -- Sight pos
SWEP.SightAng = Angle(-5,-1,0) -- Sight ang

SWEP.Mobility = 4
