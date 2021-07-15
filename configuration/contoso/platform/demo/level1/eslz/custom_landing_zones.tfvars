custom_landing_zones = {
  ctsdemo-corp = {
    display_name               = "Corp"
    parent_management_group_id = "ctsdemo-landing-zones"
    archetype_config = {
      archetype_id   = "landingzone_corp"
      parameters     = {}
      access_control = {}
    }
    subscriptions    = {}
    subscription_ids = []
  }
  ctsdemo-online = {
    display_name               = "Online"
    parent_management_group_id = "ctsdemo-landing-zones"
    archetype_config = {
      archetype_id   = "landingzone_online"
      parameters     = {}
      access_control = {}
    }
    subscriptions    = {}
    subscription_ids = []
  }
}