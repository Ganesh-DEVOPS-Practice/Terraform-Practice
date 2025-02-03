Module Developement
--------------------
-> DRY
-> write code once use it when we req
-> we write modules, arguments will be same but values will be chaged 
we pass it from other module or main.tf file 

-> ex: main.tf 
# syntax:
module "Any_name" {
    # here provide all parameters values (req inpts i.e varibales)
    source = "../ec2_mod"
    var1 = val1
}

-> source is refering given folder (module), which has ec2 code, that parameters we provide, will consider as arguments 

# if varible block with name is given in mod with out default and no varibales.tf then it is the req varibale when we call module from main.tf

# module is developed once, but can be called multiple times 
-> Note : provider.tf will be at user i.e where we are calling module

folder(main) ---> where we call modules and (provider.tf) file
    | 
    -> main.tf file 
    -> provider.tf   
ec2_module
    |
    -> configuration files 


main.tf 
------
module "ec2_mod"{
    source = "../ec2_module"  # give exact path of module 
    env = "prod"   # these are variables for given module, not parameters.
}

-> terraform init if we write new module so that terraform install it 

Note:
-----
-> if module is devloped then write readme.MD file so that user will understand how to use and what are inputs and outputs of given module



ex: readme.MD:
------------------------------------------------------------------------------------------

# Terraform AWS EC2

## Arguments
ami_id -> (mandatory) User must provide AMI_ID. This is string format.
instance_type - (optional), default is t3.micro 
security_group_ids - (mandatory), User must provide list of Sg ID

## outputs:
public_ip -> Public IP of the instance created.
Private_ip -> private IP of the instance created.
instance_id -> instance ID of the instance created.

# instance_type allowed are "t3.micro","t3.medium","t3.small"

-------------------------------------------------------------------------------------------




-> how users can take output :
-> create outputs.tf file 

syn:
----
output "public_ip"{
    value = module.moduleName_we_given.output_name_from_module_output_file
}

ex:
---
output "public_ip"{
    value = module.ec2_mod.public_ip
}


Advantages:
---------
1. Code re-use 
2. as module is used by calling (if we modify code will reflect in all)
3. best practice can be enforced 



Note: (restrict user input):
----------------------------

variable "instance_type" {
    default = "t3.micro"
    type = string 
    validation {
        condition = contains(["t3.micro","t3.medium","t3.small"], var.instance_type)
        error_message = "instance_type can only be on of t3.micro,t3.medium,t3.small"
    }
}






VPC-> virtual private cloud 
-------------------------------
-> we will have data center (set of all servers) 
# VPC is a isolated datacenter in cloud. resources created inside vpc is completely private..


terraform init -backend-config="Test/backend.s3.remote"