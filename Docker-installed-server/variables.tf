variable "instance_type" {
    default = "t3.medium"
    type = string
}

variable "Tags" {
    type = map
    default = {
        Tester = "Ganesh-TF"
        ppmid = 123456
    }
}