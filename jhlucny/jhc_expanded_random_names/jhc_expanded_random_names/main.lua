core.declare( "jhc_expanded_random_names", {} )

require( "jhc_expanded_random_names:names" )

function jhc_expanded_random_names.OnLoad()
    jhc_expanded_random_names.install_random_name_wrapper()
end
