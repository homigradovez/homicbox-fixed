CreateClientConVar("hg_fov", "120", true, false, "#hg.fov", 70, 155)
CreateClientConVar("hg_newcamera", "1", true, false, "#hg.newcam", 0, 1)
CreateClientConVar("hg_shakecam", "1", true, false, "#hg.shakecam", 0, 1)
CreateClientConVar("hg_fake_mode", "1", true, false, "abc123", 0, 1)
CreateClientConVar("hg_cool_camera","1",true,false,"real cool",0,1)
CreateClientConVar("hg_coolcamera_intensity","6",true,false,"real cool x2",2,60)
CreateClientConVar("hg_vehicle_cam","1",true,false,"🚚🚑🚑🚚")
CreateClientConVar("hg_bodycam","0",true,false,"BODYCAM REALISM UNRECORD")

CreateClientConVar( "hg_always_e", "0", true, false, "casual bruuuh", 0, 1 )

local hg_always_e  = GetConVar("hg_always_e")



local hg_cool_camera = GetConVar("hg_cool_camera")
local hg_coolcamera_intensity = GetConVar("hg_coolcamera_intensity")
local hg_fake_mode = GetConVar("hg_fake_mode")
local hg_newcamera = GetConVar("hg_newcamera")
local hg_shakecam = GetConVar("hg_shakecam")
local hg_vehicle_cam = GetConVar("hg_vehicle_cam")
local hg_bodycam = GetConVar("hg_bodycam")
local VPunch = Angle(0, 0, 0)
local viewPunchDecay = 4.5
local lastGrounded = true
local landPunchPending = false
local vector_origin = Vector(0,0,0)
function AVPunch(punch)
    VPunch = VPunch + punch
end

local whitelistweps = {
	["weapon_physgun"] = true,
	["gmod_tool"] = true,
	["gmod_camera"] = true,
	["weapon_physcannon"] = true,
	["wep_jack_gmod_eztoolbox"] = true
}

function RagdollOwner(rag)
	for k, v in ipairs(player.GetAll()) do
		local ply = v
		if ply:GetNWEntity("DeathRagdoll") == rag then return ply end
	end

	return false
end
local helmet

net.Receive("shlem",function()
helmet = net.ReadEntity()
end)

hook.Add("Think", "pophead", function()
    local ply = LocalPlayer()
    
    if ply:GetViewEntity() ~= ply then return end
    
    if IsValid(ply:GetNWEntity("DeathRagdoll")) and ply:GetNWEntity("DeathRagdoll"):GetNWBool("Smashed", false) then return end
end)

hook.Add("PrePlayerDraw", "HideFakePlayers", function(ply)
    if ply:GetNWBool("fake", false) then
        return true
    end
end)

hook.Add("Think","mouthanim",function()
	for i, ply in pairs(player.GetAll()) do
		local ent = IsValid(ply:GetNWEntity("DeathRagdoll")) and ply:GetNWEntity("DeathRagdoll") or ply

		local flexes = {
			ent:GetFlexIDByName( "jaw_drop" ),
			ent:GetFlexIDByName( "left_part" ),
			ent:GetFlexIDByName( "right_part" ),
			ent:GetFlexIDByName( "left_mouth_drop" ),
			ent:GetFlexIDByName( "right_mouth_drop" )
		}

        local falling = 0		
		if ent:GetVelocity():Length() > 300 then
		    falling = ent:GetVelocity():Length() / 300
		else
			falling = 0
		end
		local weight = ply:IsSpeaking() && math.Clamp((ply:VoiceVolume() * 21), 0, 21 ) || 0

		for k, v in pairs( flexes ) do
			ent:SetFlexWeight(v, weight + falling)
		end
	end
end)

surface.CreateFont(
	"Arial",
	{
		font = "Arial",
		size = 50,
		weight = 700,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = true,
		outline = false,
	}
)

local weps = {
	["glock18"] = true,
	["glock"] = true,
	["ak74"] = true,
	["ar15"] = true,
	["beretta"] = true,
	["fiveseven"] = true,
	["mp5"] = true,
	["m3super"] = true,
	["p220"] = true,
	["hk_usp"] = true,
	["hk_usps"] = true,
	["akm"] = true,
	["deagle"] = true,
	["magnum"] = true,
	["ak74u"] = true,
	["l1a1"] = true,
	["fal"] = true,
	["galil"] = true,
	["galilsar"] = true,
	["m14"] = true,
	["m1a1"] = true,
	["mk18"] = true,
	["m249"] = true,
	["m4a1"] = true,
	["minu14"] = true,
	["mp40"] = true,
	["rpk"] = true,
	["ump"] = true
}

local MyLerp = 0
local ViewPunching
local wep
local ang

-- ===== ФУНКЦИЯ ДЛЯ ПРОВЕРКИ ИСПОЛЬЗОВАНИЯ ЭМПЛЕЙСМЕНТА GREDWICH =====
local function IsUsingGredEmplacement(ply)
    if not IsValid(ply) then return false end
    
    -- Проверяем через NW переменную Shooter у эмплейсмента
    -- В Gredwich Shooter устанавливается когда игрок садится в турель
    for k, ent in pairs(ents.FindByClass("gred_emp_*")) do
        if IsValid(ent) and ent.GetShooter then
            local shooter = ent:GetShooter()
            if IsValid(shooter) and shooter == ply then
                return true
            end
        end
    end
    
    return false
end

local function scopeAiming()
	local wep = LocalPlayer():GetActiveWeapon()

	return IsValid(wep) and LocalPlayer():KeyDown(IN_ATTACK2) and not LocalPlayer():KeyDown(IN_SPEED)
end

function SpecCam(ply, vec, ang, fov, znear, zfar)
	if ply:Team() == 1002 then return end
	local hand = ply:GetAttachment(ply:LookupAttachment("anim_attachment_rh"))
	local eye = ply:GetAttachment(ply:LookupAttachment("eyes"))
	local org = eye.Pos
	local ang1 = eye.Ang + Angle(-10, 5, 0)
	local org1 = eye.Pos + eye.Ang:Up() * 4 + eye.Ang:Forward() * -5 + eye.Ang:Right() * 6.5
	if ply:GetNWBool("fake") == true and IsValid(ply:GetNWEntity("DeathRagdoll")) then
		local attach = ply:GetNWEntity("DeathRagdoll"):GetAttachment(1)
		local view = {
			origin = attach.Pos + attach.Ang:Up() * 4 + attach.Ang:Forward() * -5 + attach.Ang:Right() * 6.5,
			angles = attach.Ang + Angle(-10, 5, 0),
			fov = GetConVar("hg_fov"):GetInt(),
			drawviewer = true,
			znear = 0.1,
    			dopostprocess = true,
		}




		return view
	end

	local view = {
		origin = org1,
		angles = ang1,
		fov = GetConVar("hg_fov"):GetInt(),
		drawviewer = true,
		znear = 0.1
	}

	return view
end

hook.Add(
	"HUDPaint",
	"SpecPaint",
	function()
		local lply = LocalPlayer()
		local specPly = lply:GetNWEntity("SpecPly")
		if lply:Alive() then return end
		if not specPly:IsValid() then return end
		local ActivWeapon = specPly:GetActiveWeapon()
		if not IsValid(ActivWeapon) then return end
		ActivWeapon:DrawHUD()
	end
)

local sightAng = Angle(0, 0, 0)
local podkid = 0
local oldFakeOrigin = Vector(0, 0, 0)
local oldFakeAng = Angle(0, 0, 0)
local oldOrigin = Vector(0, 0, 0)
local oldAng = Angle(0, 0, 0)
local lerping = 1

hook.Add("HUDDrawTargetID", "HidePlayerInfo", function() return false end)

function HomigradCam(ply, vec, ang, fov, znear, zfar)
    -- ===== ЕСЛИ ИГРОК ИСПОЛЬЗУЕТ ЭМПЛЕЙСМЕНТ GREDWICH - ПРОПУСКАЕМ =====
    if IsUsingGredEmplacement(ply) then
        return
    end

	local hand = ply:GetAttachment(ply:LookupAttachment("anim_attachment_rh"))
	local eye4 = ply:GetAttachment(ply:LookupAttachment("eyes"))
	local org = eye4.Pos
	local ang1 = LerpAngle(0, ply:EyeAngles(), eye4.Ang)
	local org1
	if hg_newcamera:GetBool() then
		org1 = eye4.Pos + eye4.Ang:Up() * 3.5 + eye4.Ang:Forward() * -2.5
	else
		org1 = eye4.Pos + eye4.Ang:Up() * 2 + eye4.Ang:Forward() * 2.5
	end
--Для отключения камеры в транспорте и при взаимодействии с энтитями.
    if ply:InVehicle() or IsValid(ply:GetVehicle()) or ply:GetViewEntity() ~= ply then
        return
    end

	if ply:GetActiveWeapon().CamPos then
		local wep = ply:GetActiveWeapon()
		org1 = eye4.Pos + eye4.Ang:Up() * wep.camposup + eye4.Ang:Forward() * wep.camposforward + eye4.Ang:Right() * wep.camposright
	end

	if ply:Team() == 1002 then return end
	if not ply:Alive() then
		local specPly = ply:GetNWEntity("SpecPly")
		if not specPly:IsValid() then
			if not IsValid(ply:GetNWEntity("DeathRagdoll")) then return end
			local attach = ply:GetNWEntity("DeathRagdoll"):GetAttachment(ply:GetNWEntity("DeathRagdoll"):LookupAttachment("eyes"))
			local bone = ply:GetNWEntity("DeathRagdoll"):LookupBone("ValveBiped.Bip01_Head1")
			if bone then ply:GetNWEntity("DeathRagdoll"):ManipulateBoneScale(bone, vector_origin) end
			local view = {
				origin = attach.Pos,
				angles = LerpAngle(0.2, ang1, attach.Ang),
				fov = GetConVar("hg_fov"):GetInt(),
				drawviewer = true
			}
			lerping = 1
			return view
		end
		return SpecCam(specPly)
	end
	if ply:GetNWBool("fake") == true and IsValid(ply:GetNWEntity("DeathRagdoll")) then
		local attach = ply:GetNWEntity("DeathRagdoll"):GetAttachment(ply:GetNWEntity("DeathRagdoll"):LookupAttachment("eyes"))
		local bone = ply:GetNWEntity("DeathRagdoll"):LookupBone("ValveBiped.Bip01_Head1")
		if bone then ply:GetNWEntity("DeathRagdoll"):ManipulateBoneScale(bone, vector_origin) end
		lerping = Lerp(3 * FrameTime(), lerping, 0)

		local view = {
			origin = LerpVector(lerping, attach.Pos, oldOrigin),
			angles = LerpAngle(lerping, LerpAngle(0.35, ang1, attach.Ang), oldAng),
			fov = GetConVar("hg_fov"):GetInt(),
			drawviewer = true
		}
		oldFakeOrigin = view.origin
		oldFakeAng = view.angles

		return view
	end
	if IsValid(ply) and not hg_vehicle_cam:GetBool() then return end
	if IsValid(ply) and IsValid(ply:GetActiveWeapon()) then
		wep = ply:GetActiveWeapon()
		if whitelistweps[wep:GetClass()] and not ply:InVehicle() then return end
	end
	sightAng = sightAng or hand.Pos
	if ply:Alive() and IsValid(ply) and IsValid(ply) and IsValid(ply:GetActiveWeapon()) then
		local bone = ply:LookupBone("ValveBiped.Bip01_Head1")
		if bone and ply:GetViewEntity() == ply then 
        ply:ManipulateBoneScale(bone, vector_origin) 
        end
		local weaponClass = wep:GetClass()
		local guninfo = weapons.Get(weaponClass)
		if guninfo and guninfo.Base == "salat_base" then
			if scopeAiming() then
				MyLerp = Lerp(4 * FrameTime(), MyLerp, 1)
				if hand then
					local forward = hand.Ang:Forward()
					org = org + hand.Ang:Forward() * 101
				end
			else
				MyLerp = Lerp(4 * FrameTime(), MyLerp, 0.1)
			end

			podkid = Lerp(0.1, podkid, math.Clamp((guninfo.HoldType ~= "revolver" and ply:GetActiveWeapon():GetNWFloat("VisualRecoil") / 4) or ply:GetActiveWeapon():GetNWFloat("VisualRecoil") / 1, 0, 10))
			if hand then
				org = hand.Pos 
				+ hand.Ang:Up() * guninfo.sightPos.x
				- hand.Ang:Forward() * guninfo.sightPos.y
				+ hand.Ang:Right() * guninfo.sightPos.z

				ang = hand.Ang + guninfo.sightAng + Angle(podkid * -15, 0, 0)
			end
		end
	end
	if ang then sightAng = LerpAngle(3 * FrameTime(), sightAng, ang) end
	if ply:Alive() then
		local bone = ply:LookupBone("ValveBiped.Bip01_Head1")
		if bone then ply:ManipulateBoneScale(bone, vector_origin) end
	end
	if ply:InVehicle() == true then
		org = eye4.Pos + eye4.Ang:Forward() * 0.8
		ang = eye4.Ang
		MyLerp = 1
		local bone = ply:LookupBone("ValveBiped.Bip01_Head1")
		if bone then ply:ManipulateBoneScale(bone, vector_origin) end
		anglerp = LerpAngle(MyLerp, ang1, ang)
	else
		anglerp = LerpAngle(MyLerp / 2, ang1, sightAng or Angle(0, 0, 0))
	end



oldHandAng = oldHandAng or hand.Ang
oldOrigin  = oldOrigin or org

local wep = ply:GetActiveWeapon()
if wep.Base == "salat_base" and wep.REWORK then
    local recoil = wep:GetNWFloat("VisualRecoil")
    if recoil > 0.001 then
        local diff = oldHandAng - hand.Ang
        diff:Normalize()
        local fix = diff[2] * 0.2 * recoil
        local step = 1.7 * recoil

        local target = org + hand.Ang:Forward() * step
        target = target + hand.Ang:Right() * fix

        local lerpAlpha = math.Clamp(FrameTime() * 1110, 0, 1)
        org = LerpVector(lerpAlpha, org, target)
    end
end

oldHandAng = hand.Ang
oldOrigin  = org

	lerping = Lerp(3 * FrameTime(), lerping, 1)
	local view = {
		origin = LerpVector(lerping, oldFakeOrigin, LerpVector(MyLerp, org1, org)),
		angles = LerpAngle(lerping, oldFakeAng, LerpAngle(0.01, anglerp, ang1)),
		fov = GetConVar("hg_fov"):GetInt(),
		drawviewer = true,
		znear = 0.8
	}
	oldOrigin = view.origin
	oldAng = view.angles

	VPunch = LerpAngle(FrameTime() * viewPunchDecay, VPunch, Angle(0, 0, 0))
	view.angles = view.angles + VPunch

if IsValid(helmet) and ply:GetViewEntity() == ply then 
    helmet:SetNoDraw(true) 
end

	if hg_cool_camera:GetBool() then
		local val = math.min(math.Round((1 / engine.AbsoluteFrameTime()) / 60, 1), 1)

		diffpos = Lerp(0.1, diffpos or Vector(), (view.origin - (oldview and oldview.origin or view.origin)) / 6)
		diffang = Lerp(0.1, diffang or Vector(), (view.angles:Forward() - (oldview and oldview.angles or view.angles):Forward()) * 50)

		view.angles[3] = view.angles[3] + math.Clamp(diffang:Dot(view.angles:Right()) * hg_coolcamera_intensity:GetInt() * val, -11, 111)
		view.angles[3] = view.angles[3] + math.Clamp(diffpos:Dot(view.angles:Right()) * 30 * val, -11, 111)
	end

	oldview = table.Copy(view)



	return view
end


net.Receive("resetfake",function()
    if not IsValid(LocalPlayer()) or not LocalPlayer():Alive() then return end
print(123)
ResetAngles()
    LocalPlayer():SetEyeAngles(Angle(0,0,0))
    LocalPlayer():SetEyeAngles(Angle(0,0,0))
    LocalPlayer():SetEyeAngles(Angle(0,0,0))
end)


hook.Add("CalcView", "salat.ahuel.view", HomigradCam)

-- ===== ПЕРЕОПРЕДЕЛЯЕМ RenderScene ДЛЯ КОРРЕКТНОЙ РАБОТЫ С GREDWICH =====
hook.Add(
	"RenderScene",
	"fwep-viewbobfix",
	function(pos, angle, fov)
        local ply = LocalPlayer()
        
        -- Если игрок использует эмплейсмент Gredwich - НЕ вмешиваемся в рендер
        if IsUsingGredEmplacement(ply) then
            return
        end
        
		local view = hook.Run("CalcView", ply, pos, angle, fov)
		local view = {
			x = 0,
			y = 0,
			drawhud = true,
			drawviewmodel = false,
			dopostprocess = true,
			drawmonitors = true
		}

		local calcView = HomigradCam(ply, pos, angle, fov)
		if not calcView then return end
		view.fov = calcView.fov
		view.origin = calcView.origin
		view.angles = calcView.angles
		view.drawviewmodel = not calcView.drawviewer
		render.RenderView(view)
		return true
	end
)--

-- Coded by SadSalat
hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = false,
	["CHudSecondaryAmmo"] = true,
	["CHudCrosshair"] = true,
}

hook.Add(
	"HUDShouldDraw",
	"HideHUD",
	function(name)
		if hide[name] then return false end
	end
)

local allowedRanks = {
	["superadmin"] = true,
	["admin"] = true,
	["operator"] = true,
	["moderator"] = true,
	["user"] = true,
	["viptest"] = true,
	["kakaha"] = true,
}



local camyaw = 0
local campitch = 0
local init = false

hook.Add("InputMouseApply", "Homigrad", function(cmd, x, y, angle)
	local ply = LocalPlayer()
	if not IsValid(ply) or not ply:Alive() then return end
	if not ply:GetNWBool("fake", true) then return end
	if not hg_fake_mode:GetBool() then return end
	local rag = ply:GetNWEntity("DeathRagdoll")
	if not IsValid(rag) then return end
	local att = rag:GetAttachment(rag:LookupAttachment("eyes"))
	if not att then return end
	if not init then
		local viewAng = cmd:GetViewAngles()
		camyaw = viewAng.yaw
		campitch = viewAng.pitch
		init = true
	end
	local roll = math.rad(angle.roll)
	local dx = x * math.cos(roll) - y * math.sin(roll)
	local dy = x * math.sin(roll) + y * math.cos(roll)
	camyaw = camyaw - dx / 50
	campitch = campitch + dy / 50
	cmd:SetViewAngles(Angle(campitch, camyaw, 0))
	return true
end)

hook.Add("Think", "Gomigrad", function()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if not ply:GetNWBool("fake", true) or not hg_fake_mode:GetBool() then
		if init then
			init = false
			camyaw = 0
			campitch = 0
		end
	end
end)


hook.Add(
	"ContextMenuOpen",
	"hide_spawnmenu",
	function()
		if not allowedRanks[LocalPlayer():GetUserGroup()] then return false end
	end
)

hook.Add(
	"SpawnMenuOpen",
	"hide_spawnmenu",
	function()
		if not allowedRanks[LocalPlayer():GetUserGroup()] then return false end
	end
)

hook.Add("Think", "camera", function()
if not hg_shakecam:GetBool() then return end
    local ply = LocalPlayer()
    if not IsValid(ply) or not ply:Alive() or ply:InVehicle() or ply:GetNWBool("fake") then return end
    if ply:GetMoveType() == MOVETYPE_NOCLIP then return end

if ply:IsWalking() and ply:OnGround() and ply:GetVelocity():Length() >= 10 then
 local punch = Angle(math.sin(CurTime() * 2) * 0.09, math.sin(CurTime() * -2) * 0.05 + math.Rand(-0.01, 0.01), math.sin(CurTime() * 4) * 0.15 + math.Rand(-0.01, 0.01))
    AVPunch(punch)
end

if ply:GetVelocity():Length() >= 15 and not ply:IsWalking() and not ply:IsSprinting() and ply:OnGround() then
    local punch = Angle(math.sin(CurTime() * 4) * 0.09, math.sin(CurTime() * 2) * 0.05 + math.Rand(-0.01, 0.01), math.sin(CurTime() * 8) * 0.15 + math.Rand(-0.01, 0.01))
    AVPunch(punch)
end

if ply:IsSprinting() and ply:OnGround() and ply:GetVelocity():Length() >= 1 then
    local punch = Angle(math.sin(CurTime() * 14) * 0.15 + math.Rand(-0.03, 0.03), math.sin(CurTime() * 12) * 0.05 + math.Rand(-0.01, 0.01), math.sin(CurTime() * 8) * 0.15 + math.Rand(-0.01, 0.01))
    AVPunch(punch)
end
    if not ply:OnGround() and last then
        landPunch = true
    end
   if ply:OnGround() and not last and landPunch and ply:GetVelocity():Length() >= 1 then
       AVPunch(Angle(0,0,math.random(-10,-15 )))
        landPunch = false
    end--
    last = ply:OnGround()
end)


hook.Add("PlayerDeath","Homigrad",function(ply)
if not IsValid(ply:GetNWEntity("DeathRagdoll")) then return end
local rag = ply:GetNWEntity("DeathRagdoll")
rag:ManipulateBoneScale(rag:LookupBone("ValveBiped.Bip01_Head1"),Vector(1,1,1))
end)

surface.CreateFont("BodyCamFont",{
	font = "Arial",
	size = 40,
	weight = 600,
	antialias = false,
	outline = false,
	shadow = true
})

local huy = math.random(1,10)
hook.Add("RenderScreenspaceEffects","BloomEffect-homigrad",function()
	if GetConVar("hg_bodycam"):GetInt() == 1 and LocalPlayer():Alive() then
		local splitTbl = string.Split(util.DateStamp()," ")
		local date,time = splitTbl[1],splitTbl[2]
		time = string.Replace(time,"-",":")

		draw.Text( {
			text = date.." "..time.." -0400",
			font = "BodyCamFont",
			pos = { ScrW() - 480, 50 }
		} )
		draw.Text( {
			text = "AXON BODY "..huy.." XG8A754GH",
			font = "BodyCamFont",
			pos = { ScrW() - 500, 100 }
		} )

		surface.SetDrawColor( 255, 255, 0, 255 )
		draw.NoTexture()

		DrawBloom( 0.5, 1, 9, 9, 1, 1.2, 0.8, 0.8, 1.2 )
		DrawSharpen( 1, 1.2 )
		DrawColorModify(tab)
		BlurScreen(0.3,55)
		LocalPlayer():SetDSP(55,false)
		DrawMotionBlur(0.5,0.5,0.00001)
		local k3 = 6
		DrawCA(4 * k3, 2 * k3, 0, 2 * k3, 1 * k3, 0)
	end
end)

hook.Add("Think", "RestoreHeadBoneOnViewEntity", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    
    if ply:GetViewEntity() ~= ply then
        local bone = ply:LookupBone("ValveBiped.Bip01_Head1")
        if bone and ply:GetManipulateBoneScale(bone) ~= Vector(1,1,1) then
            ply:ManipulateBoneScale(bone, Vector(1,1,1))
        end
        
        if IsValid(ply:GetNWEntity("DeathRagdoll")) then
            local rag = ply:GetNWEntity("DeathRagdoll")
            local ragBone = rag:LookupBone("ValveBiped.Bip01_Head1")
            if ragBone and rag:GetManipulateBoneScale(ragBone) ~= Vector(1,1,1) then
                rag:ManipulateBoneScale(ragBone, Vector(1,1,1))
            end
        end
    end
end)


hook.Add("Think", "HideHelmetWhenAlive", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    
    if ply:GetViewEntity() ~= ply then
        if ply.EZarmor and ply.EZarmorModels then
            for i, mdl in pairs(ply.EZarmorModels) do
                if IsValid(mdl) then
                    mdl.RenderOverride = nil
                    mdl:SetNoDraw(false)
                end
            end
        end
        return
    end
    
    if not ply:Alive() or not ply.EZarmor or not ply.EZarmor.items then return end

    for i, armorData in pairs(ply.EZarmor.items) do
        local armorName = armorData.name
        local armorInfo = JMod.ArmorTable[armorName]
        if armorInfo and armorInfo.bon == "ValveBiped.Bip01_Head1" then
            local mdl = ply.EZarmorModels and ply.EZarmorModels[i]
            if IsValid(mdl) then
                if mdl.RenderOverride ~= JMod_HideHelmet then
                    mdl.RenderOverride = JMod_HideHelmet
                end
                if not mdl:GetNoDraw() then
                    mdl:SetNoDraw(true)
                end
            end
        end
    end
end)

function JMod_HideHelmet() end
surface.CreateFont("HomigradFontBig",{
		font = "Roboto",
		size = 25,
		weight = 1100,
		outline = false,
		shadow = true
	})
