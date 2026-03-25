core.declare( "jhc_assemblies_unlock", {} )

function jhc_assemblies_unlock.unlock_current_player_assemblies()
    if not player or not player.__props or not player.__props.assemblies or not mod_arrays then
        return
    end

    for _, assembly in ipairs( mod_arrays ) do
        if assembly.id and player.__props.assemblies[assembly.id] == nil then
            player.__props.assemblies[assembly.id] = 1
        end
    end
end

function jhc_assemblies_unlock.wrap_hook( module_table, hook_name )
    local original = rawget( module_table, hook_name )

    module_table[hook_name] = function( ... )
        if original then
            original( ... )
        end
        jhc_assemblies_unlock.unlock_current_player_assemblies()
    end
end

function jhc_assemblies_unlock.install_wrapper()
    if jhc_assemblies_unlock._installed then
        return
    end

    local module_id = rawget( _G, "core_module" )
    if type( module_id ) ~= "string" then
        return
    end

    local module_table = rawget( _G, module_id )
    if type( module_table ) ~= "table" then
        return
    end

    jhc_assemblies_unlock.wrap_hook( module_table, "OnCreatePlayer" )
    jhc_assemblies_unlock.wrap_hook( module_table, "OnLoaded" )
    jhc_assemblies_unlock._installed = true
end

function jhc_assemblies_unlock.OnLoad()
    jhc_assemblies_unlock.install_wrapper()
end
