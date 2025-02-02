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

