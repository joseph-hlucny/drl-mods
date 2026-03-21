function jhc_expanded_random_names.install_random_name_wrapper()
    if jhc_expanded_random_names._installed then
        return
    end

    local original_get_random_name = rawget( jhc, "GetRandomName" )

    jhc_expanded_random_names.original_get_random_name = original_get_random_name
    require( "jhc_expanded_random_names:name_pool" )

    function jhc.GetRandomName()
        local pool = jhc_expanded_random_names.name_pool
        if pool and #pool > 0 then
            return pool[ math.random( #pool ) ]
        end

        if original_get_random_name then
            return original_get_random_name()
        end

        return "John Doom"
    end

    jhc_expanded_random_names._installed = true
end
