
```bash
export environment=sandpit
export caf_environment=sandpit

# Note: if you have deployed the demo environment and want to upgrade it to the sandpit configuration,
# set
# export caf_environment=demo

rover -lz /tf/caf/landingzones/caf_solution/add-ons/azure_devops \
  -var-folder configuration/${environment}/level0/azure_devops \
  -parallelism 30 \
  -level level0 \
  -env ${caf_environment} \
  -launchpad \
  -a

```