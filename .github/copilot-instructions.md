Define all variables only in variables.tf, and make sure each variable has a valid description and type.
Resource names provided in tasks should be defined via variables or generated dynamically/concatenated (e.g., in locals using Terraform functions). Avoid hardcoding resource names in resource definitions or using the default property for variables.
Put all non-sensitive input values into terrafo
rm.tfvars.
Apply the required tag to all created resources:
Project={vars.name_of_the_var}