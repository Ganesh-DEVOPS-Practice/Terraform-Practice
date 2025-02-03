## we are creating our own VPC module...



# Tags
we have common_tags: tags used for all resources in the proj







--------------------------------------------------------------------------------

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

-> first we need elastic public ip