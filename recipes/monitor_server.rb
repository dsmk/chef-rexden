include_recipe 'icinga2::default'
include_recipe 'icinga2::server'
#include_recipe 'icinga2-test::default'

# instead we need to include monitoring rules for our environment
# we should also add nrpe to our rexden default.
#
