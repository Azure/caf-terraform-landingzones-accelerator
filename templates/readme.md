The templates have been moved into the Azure landingzone code for version 2201.0 and upper.

## Supported scenarios and variations

The following matrix describes the current capabilities to generate configuration files:

| Scenario                                  | Mono subscription  | Multi subscriptions | Interactive        | Pipelines | Example files |
|:------------------------------------------|:------------------:|:-------------------:|:------------------:|:---------:|:-------------:|
| **- Level 0 -**                           |                    |                     |                    |           |               |
| launchpad                                 | :white_check_mark: | :white_check_mark:  | :white_check_mark: |           |               |
| launchpad credentials                     |                    | :white_check_mark:  | :white_check_mark: |           |               |
| subscription creation delegation          | N/A                | :white_check_mark:  | :white_check_mark: |           |               |
| **gitops bootstrap with cloud pipelines** |                    |                     |                    |           |               |
| ado_pipelines                             |                    |                     |                    |           |               |
| github_pipelines                          |                    |                     |                    |           |               |
| **gitops interactive bootstrap**          |                    |                     |                    |           |               |
| ado_pipelines                             |                    |                     |                    |           |               |
| github_pipelines                          |                    |                     |                    |           |               |
| **- Level 1 -**                           |                    |                     |                    |           |               |
| management                                | :white_check_mark: | :white_check_mark:  | :white_check_mark: |           |               |
| identity                                  |                    | :white_check_mark:  | :white_check_mark: |           |               |
| core_enterprise_scale                     | :white_check_mark: | :white_check_mark:  | :white_check_mark: |           |               |
| subscriptions                             | N/A                | :white_check_mark:  | :white_check_mark: |           |               |
| **- Level 2 -**                           |                    |                     |                    |           |               |
| connectivity                              |                    | :white_check_mark:  | :white_check_mark: |           |               |
| identity                                  |                    | :white_check_mark:  | :white_check_mark: |           |               |
| subscription vending machine              | N/A                | :white_check_mark:  | :white_check_mark: |           |               |
| **- Level 3 -**                           |                    |                     |                    |           |               |
| any resource LZ                           |                    | :white_check_mark:  | :white_check_mark: |           |               |
| **- Level 4 -**                           |                    |                     |                    |           |               |
| any resource LZ                           |                    | :white_check_mark:  | :white_check_mark: |           |               |
