## we are creating our own VPC module...
------------------------------------------------------------------------
## How we created:
0. create s3 and dynamo db for backend.
-> add provider.tf file in testing folder, we can use all tf files as usual 
1. created vpc resource and given all req variables and outputs 
2. we ask proj_name and env for the mod as mandatory then added in all resources to identify easily 
3. kept common tags and vpc tags block as optional, user can pass those values when req

4. create IGW (internet gateway) and igw_tags 
5. for high availability we need to maintain atleast 2 AZ
so lets create subnets 
-> public 1a and 1b   --> 10.0.1.0/24 , 10.0.2.0/24 
-> private 1a and 1b  --> 10.0.11.0/24 , 10.0.12.0/24 
-> db 1a and 1b       --> 10.0.21.0/24 , 10.0.22.0/24 
---> we create 6 subnets by using count loop

# note write a condition for cidrs block in subnet it should take list of exactly "2" cidrs only, not more than that

# we need AZ first 2,
-> by using data source get AZ in that region then get first 2 out of them, use these for our proj 
6. so we create data.tf file
-> sample o/p is:

az_info = {
      + all_availability_zones = null
      + exclude_names          = null
      + exclude_zone_ids       = null
      + filter                 = null
      + group_names            = [
          + "us-east-1-zg-1",
        ]
      + id                     = "us-east-1"
      + names                  = [
          + "us-east-1a",
          + "us-east-1b",
          + "us-east-1c",
          + "us-east-1d",
          + "us-east-1e",
          + "us-east-1f",
        ]
      + state                  = "available"
      + timeouts               = null
      + zone_ids               = [
          + "use1-az2",
          + "use1-az4",
          + "use1-az6",
          + "use1-az1",
          + "use1-az3",
          + "use1-az5",
        ]
    }

-> az_info.names --> gives list of names 

# lets give in tags -> Name = expense-dev-public-us-east-1a

-> create 3 subnet blocks with count of 2 

## note : "map_public_ip_on_launch" parameter in subnets will be false, enable it, to get public access i.e public ips


---> Database subnets are some what special 
# create "database_subnet_group" --> all database subnets will be under this group
--> we will discuss this in RDS concept 

7. Create aws_db_subnet_group  under RDS resource (pan) we get this

# var.somevalue[*] ---> will result list of values that variable holding

8. lets create NAT gate way 

-> first we need elastic public ip, then NAT (associate it)

## NAT --> depends_on = [aws_internet_gateway.main] 
-> NAT will work only if we have IGW, but both resources are different (no dependency by default)
-> so we need to use "depends_on" to tell terraform.


---> create 3 route Tables --> public,private,database 

-> now create routes ..
1. public route -> IGW to public subnet  
(public subnets, IGW use cheskoni internet access chestay)
2. private route -> NAT to private
(private subnets, NAT gate way use cheskoni internet connect avtay )


--> we need to associate route tables with respective subnets
* we have 6 subnets so we create 6 route table associations (but we have 3 route tables) by using count
-> 2 subnets will be associated by one route table  



## VPC peering
-> we ask user weather he wants vpc peering or not, if yes then our module will connect to default vpc in the same region 

we use count as 1 if peering req, else 0 ( we use this condition)
--> create peering.tf file for this

--> use data source to get default vpc --> we have flag default = true to get it 

o/p is ex:
default_vpc_inf = {
  arn = "ertyuiop"
  | | | 
  id = "23456789" # default vpc id
}

-> can get it by default_vpc_inf.id 
-> we have auto_accept parameter, peering in acceptor vpc will be accepted automatically 

@ now we created VPC peering (maain road between 2 vpcs)
but we need to add internal routes ( connection between area to area b/w two villages)

-> if we create route resource then it will be created all time, in order to restrict it, we need to keep a condition with count 
count = var.is_peering_req ? 1 : 0 
-> 1 means run once, 0 means dont run 
-> as we are trying to connect from public subnet we give public subnet route table 

-> created peering and route from public subnet (our vpc) with default vpc

---> lets create route from default vpc subnet(main) to our vpc

@ in order to get route table id (default), we need data source 

association.main - Indicates whether the route table is the main route table for the VPC (true | false). Route tables that do not have an association ID are not returned in the response.


 data "aws_route_table" "main" {
  vpc_id = data.aws_vpc.default.id  # get vpc id from here
  filter {
    name = "association.main"
    values = ["true"]
  }
}

## Note:
--> association.main will give main route table, even we may have multiple routetables  in default vpc, so we need this filter to get main route table.




# Test module:
module "vpc" {
  source = "../Terraform_AWS_VPC"  # for Local reference
}

module "vpc" {
  source = "git::Link"  # for Local reference
}