--- Saves all ped component and prop variations before a resurrect call.
--- GTA's NetworkResurrectLocalPlayer resets the ped model, clearing all outfit slots.
--- @param ped number
--- @return table saved clothing snapshot
function SavePedClothes(ped)
    local saved = { components = {}, props = {} }

    for i = 0, 11 do
        saved.components[i] = {
            drawable = GetPedDrawableVariation(ped, i),
            texture  = GetPedTextureVariation(ped, i),
            palette  = GetPedPaletteVariation(ped, i),
        }
    end

    for i = 0, 8 do
        saved.props[i] = {
            drawable = GetPedPropIndex(ped, i),
            texture  = GetPedPropTextureIndex(ped, i),
        }
    end

    return saved
end

--- Restores a previously saved ped clothing snapshot.
--- @param ped number
--- @param saved table snapshot returned by SavePedClothes
function RestorePedClothes(ped, saved)
    if not saved then return end

    for i = 0, 11 do
        local comp = saved.components[i]
        if comp then
            SetPedComponentVariation(ped, i, comp.drawable, comp.texture, comp.palette)
        end
    end

    for i = 0, 8 do
        local prop = saved.props[i]
        if prop then
            if prop.drawable == -1 then
                ClearPedProp(ped, i)
            else
                SetPedPropIndex(ped, i, prop.drawable, prop.texture, true)
            end
        end
    end
end
