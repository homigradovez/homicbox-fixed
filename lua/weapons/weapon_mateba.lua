SWEP.Base = 'salat_base' -- base

SWEP.PrintName 				= "Mateba Home Protection"
SWEP.Author 				= "Mateba"
SWEP.Instructions			= "The Mateba Model 6 Unica (often known simply as the Mateba or the Mateba Autorevolver) is a recoil operated semi-automatic revolver, one of only a few of this type ever produced. It was developed by Mateba, based in Pavia, Italy. Inventor Emilio Ghisoni (1937–2008), who was also famous for later designing the Chiappa Rhino, is listed as the owner of U.S. patent 4,712,466 which details the operation of the weapon."
SWEP.Category 				= "SIB Pistols"

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false

------------------------------------------

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".50 AE Magnum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 65
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/deagle/fire01.wav"
SWEP.Primary.FarSound = "snd_jack_hmcd_smp_far.wav"
SWEP.Primary.Force = 125
SWEP.ReloadTime = 2.1
SWEP.ShootWait = 0.2
SWEP.ReloadSounds = {
    [0.1] = {"zcitysnd/sound/weapons/revolver/handling/revolver_open_chamber.wav"},
    [0.8] = {"zcitysnd/sound/weapons/revolver/handling/revolver_dump_rounds_01.wav"},
    [1.2] = {"zcitysnd/sound/weapons/revolver/handling/revolver_speed_loader_insert_01.wav"},
    [1.6] = {"zcitysnd/sound/weapons/revolver/handling/revolver_close_chamber.wav"},
}

------------------------------------------

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.HoldType = "revolver"

------------------------------------------

SWEP.Slot					= 1
SWEP.SlotPos				= 2
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false

SWEP.ViewModel				= "models/pwb2/weapons/w_matebahomeprotection.mdl"
SWEP.WorldModel				= "models/pwb2/weapons/w_matebahomeprotection.mdl"

SWEP.addAng = Angle(0,0,0) -- Barrel ang adjust
SWEP.addPos = Vector(0,0,0) -- Barrel pos adjust
SWEP.SightPos = Vector(-14.5,0.4,2) -- Sight pos
SWEP.SightAng = Angle(2,10,0) -- Sight ang

function SWEP:DrawWorldModel()
    self:DrawModel()
end
