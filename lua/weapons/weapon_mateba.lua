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
SWEP.Primary.Ammo			= "9х19 mm Parabellum"
SWEP.Primary.Cone = 0
SWEP.Primary.Damage = 25
SWEP.Primary.Spread = 0
SWEP.Primary.Sound = "weapons/glock18/fire01.wav"
SWEP.Primary.FarSound = "snd_jack_hmcd_smp_far.wav"
SWEP.Primary.Force = 15
SWEP.ReloadTime = 2
SWEP.ShootWait = 0.1
SWEP.ReloadSounds = {
    [0.1] = {"weapons/glock18/clipout.wav"},
    [0.8] = {"weapons/glock18/clipin.wav"},
    [1.2] = {"weapons/glock18/slideback.wav"},
    [1.4] = {"weapons/glock18/slideforward.wav"},
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

SWEP.addAng = Angle(0.65,-0.05,0) -- Barrel ang adjust
SWEP.addPos = Vector(0,0,0) -- Barrel pos adjust
SWEP.SightPos = Vector(-14,0.5,2.7) -- Sight pos
SWEP.SightAng = Angle(0,8,0) -- Sight ang

local hg_skins = CreateClientConVar("hg_skins","1",true,false,"ubrat govno",0,1)

SWEP.PremiumSkin = {
    [4] = "skins/goldmat/goldmaterial",
}

function SWEP:DrawWorldModel()
    self:DrawModel()
	
	if not hg_skins:GetBool() then return end

    if (IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() and skins[self:GetOwner():GetUserGroup()]) then
        for k,v in pairs(self.PremiumSkin) do
            self:SetSubMaterial( k, v )
        end
        self:DrawModel()
    end
end
