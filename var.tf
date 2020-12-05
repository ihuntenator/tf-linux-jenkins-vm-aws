variable "access_key" { }
variable "secret_key" { }
variable "keyName" { }
variable "keyPath" { }
variable "region" {
   default = "ap-southeast-2"
}
variable "availabilityZone" {
   default = "ap-southeast-2a"

}
variable "instanceType" {
   default = "t2.micro"
}
variable "subnet" {
   default = "subnet-74539012"
}
variable "securityGroups" {
   type = list
   default = [ "sg-ae5329e6" ]
}
variable "instanceName" {
   default = "jenkins"
}
variable "amis" {
   default = {
     "ap-southeast-2" = "ami-085265c078d86c75b"
   }
}
