organization_url = "https://dev.azure.com/prugitops"

projects = {
  gitopsprod = {
    create      = true
    name        = "gitopsprod"
    description = "Prudential Africa - gitopsprod"
    features = {
      "artifacts"    = "disabled"
      "boards"       = "disabled"
      "pipelines"    = "enabled"
      "repositories" = "enabled"
      "testplans"    = "disabled"
    }
  }
}