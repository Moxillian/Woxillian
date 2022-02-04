local env = env
GLOBAL.setfenv(1, GLOBAL)

local function ActionDrains(inst, data)

    if data.action.action == ACTIONS.ATTACK then
        inst.components.health:DoDelta(-5)
    end
end

env.AddPrefabPostInit("woxillian", function(inst)
    if not TheWorld.ismastersim then
        return
    end

    inst:ListenForEvent("performaction", ActionDrains)
end)
