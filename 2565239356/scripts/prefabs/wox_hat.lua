local assets =
{
	Asset("ANIM", "anim/hat_mox.zip"),
	Asset("ATLAS", "images/inventoryimages/wox_hat.xml"),
	Asset("IMAGE", "images/inventoryimages/wox_hat.tex"),
}

local hungerloots = 
{
	carrot = 1,
	carrat = 0.05,
	ratatouille = 0.1,
	wetgoop = 0.01,
}

local sanityloots = 
{
	balloonparty_confetti_cloud = 1,
}

local healthloots = 
{
	healingsalve = 1,
	tillweedsalve = 0.5,
	bandage = 0.25,
	wortox_soul = 0.05,
	redcap = 0.01,
}

local function fuelme(inst)
	if inst.components.fueled:GetPercent() < 1 then
		inst.components.fueled:DoDelta(1)
		if inst.components.fueled:GetPercent() >= 1 then
			if inst.fuelmetask ~= nil then
				inst.fuelmetask:Cancel()
				inst.fuelmetask = nil
			end
		end
	else
		if inst.fuelmetask ~= nil then
			inst.fuelmetask:Cancel()
			inst.fuelmetask = nil
		end
	end
end
	
local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_hat", "hat_mox", "swap_hat")

	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAIR_HAT")
	owner.AnimState:Hide("HAIR_NOHAT")
	--owner.AnimState:Hide("HAIR")
	owner.AnimState:Hide("HEAD")
		
	if owner:HasTag("player") then
		owner.AnimState:Hide("HEAD")
		owner.AnimState:Show("HEAD_HAT")
	end
end

local function onunequip(inst, owner)

	owner.AnimState:ClearOverrideSymbol("swap_hat")
	owner.AnimState:Hide("HAT")
	owner.AnimState:Hide("HAIR_HAT")
	owner.AnimState:Show("HAIR_NOHAT")
	--owner.AnimState:Show("HAIR")
        
	if owner:HasTag("player") then
		owner.AnimState:Show("HEAD")
		owner.AnimState:Hide("HEAD_HAT")
	end
end
	
local function OnCooldown(inst)
    inst._cdtask = nil
	inst.components.useableitem.inuse = false
end

local function onuse(inst)
    local owner = inst.components.inventoryitem.owner
	
	if inst._cdtask == nil then
		inst._cdtask = inst:DoTaskInTime(480, OnCooldown)
		
		if owner ~= nil and owner.components.inventory ~= nil and inst.components.fueled:GetPercent() >= 1 then
			inst.components.fueled:SetPercent(0)
			
			if inst.fuelmetask ~= nil then
				inst.fuelmetask:Cancel()
				inst.fuelmetask = nil
			end
			
			inst.fuelmetask = inst:DoPeriodicTask(1, fuelme)
			
			owner.sg:GoToState("research")
			local hungerper = owner.components.hunger:GetPercent()
			local healthper = owner.components.health:GetPercent()
			local sanityper = owner.components.sanity:GetPercent()
			
			if owner:HasTag("wox") then
				if hungerper < 0.5 and hungerper < healthper and hungerper < sanityper then
					for i = 1, 2 do
						inst.hungerloot = SpawnPrefab(weighted_random_choice(hungerloots))
						owner.components.inventory:GiveItem(inst.hungerloot, nil, owner:GetPosition())
					end
				elseif sanityper < healthper then
					for i = 1, 3 do
						SpawnPrefab("balloonparty_confetti_cloud").Transform:SetPosition(owner.Transform:GetWorldPosition())
					end
				elseif healthper < sanityper then
					inst.healthloot = SpawnPrefab(weighted_random_choice(healthloots))
					owner.components.inventory:GiveItem(inst.healthloot, nil, owner:GetPosition())
				else
					inst.hungerloot = SpawnPrefab(weighted_random_choice(hungerloots))
					owner.components.inventory:GiveItem(inst.hungerloot, nil, owner:GetPosition())
				end
			elseif owner:HasTag("shadowmagic") then
				inst.loot = SpawnPrefab("rabbit")
				owner.components.inventory:GiveItem(inst.loot, nil, owner:GetPosition())
			else
				inst.loot = SpawnPrefab("poop")
				owner.components.inventory:GiveItem(inst.loot, nil, owner:GetPosition())
			end
			
			owner.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
			SpawnPrefab("chester_transform_fx").Transform:SetPosition(owner.Transform:GetWorldPosition())
		end
	end
end
	

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("moxhat")
	inst.AnimState:SetBuild("hat_mox")
	inst.AnimState:PlayAnimation("anim")

	inst:AddTag("hat")
 
	MakeInventoryFloatable(inst)

	inst.entity:SetPristine()
		
	inst.components.floater:SetSize("med")
	inst.components.floater:SetVerticalOffset(0.1)
	inst.components.floater:SetScale(0.63)

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/wox_hat.xml"

	inst:AddComponent("inspectable")
		
	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(onuse)
	
	inst:AddComponent("fueled")
	inst.components.fueled:InitializeFuelLevel(480)
	inst.components.fueled.accepting = false
	inst.components.fueled:SetDepletedFn(nil)
		
	if inst.fuelmetask == nil then
		inst.fuelmetask = inst:DoPeriodicTask(1, fuelme)
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED

	MakeHauntableLaunch(inst)

	return inst
end
	
return Prefab( "wox_hat", fn, assets)