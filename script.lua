---@diagnostic disable: undefined-global

local armorLib = require("KattArmor")()

models.armor:setPrimaryTexture("SKIN")

animations.armor["animation.model.gliding"]:setOverrideRot(true)

-----------------------------------------
--- Armor                             ---
-----------------------------------------

armorLib.Armor.Helmet:addParts(
    models.armor.Head.Helmet,
    models.armor.Head.HelmetHat
)

armorLib.Armor.Chestplate:addParts(
    models.armor.Body.Chestplate,
    models.armor.RightArm.RightArmArmor,
    models.armor.LeftArm.LeftArmArmor
)

armorLib.Armor.Leggings:addParts(
    models.armor.Body.Belt,
    models.armor.RightLeg.RightLegArmor,
    models.armor.LeftLeg.LeftLegArmor
)

armorLib.Armor.Boots:addParts(
    models.armor.RightLeg.RightBoot,
    models.armor.LeftLeg.LeftBoot
)

armorLib.Materials.netherite
    :setTexture(textures["samurai_layer_1"])
    :setTextureLayer2(textures["samurai_layer_2"])

-----------------------------------------
--- Elytra                            ---
-----------------------------------------

local function changeElytraVisibility(bool)
    models.ornithopter:setVisible(bool)
    models.backpack:setVisible(not bool)

    vanilla_model.all:setVisible(not bool)
    vanilla_model.elytra:setVisible(false)
    vanilla_model.armor:setVisible(false)
end

--- Constantly updates
function events.render()
    if not (string.lower(player:getItem(5):getName()) == "ornithopter" and player:getItem(5).id == "minecraft:elytra") then
        models.backpack:setVisible(false)
        models.ornithopter:setVisible(false)
        vanilla_model.armor:setVisible(false)
        return
    end

    if player:isGliding() then
        changeElytraVisibility(true)

        animations.armor["animation.model.gliding"]:play()
        animations.ornithopter["animation.elytra.gliding"]:play()
    else
        changeElytraVisibility(false)

        animations.armor["animation.model.gliding"]:stop()
        animations.ornithopter["animation.elytra.gliding"]:stop()
    end
end
