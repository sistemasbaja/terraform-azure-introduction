variable "subscription_id" {
    description = "Azure subscription Id value"
    default = "f9184ea7-e581-4d92-a279-5c499fce97b7"
}

variable "client_id" {
    description = "Client Id of the Azure account"
    default = "44250ee4-53af-4528-923c-29a9f6316a0b"
}

variable "client_secret" {
  default = "Rq48Q~J.HsKsrfRMt_CJU08i0jB4Qg9pCLf2Cdmb"
}

variable "project_code" {
  type=string
  default = "00001"
  description = "Code of the Service Order"
  validation {
    condition=length(var.project_code) > 4
    error_message="The value of the Service Order is too short."
  }  
}

variable "project_name" {
  type = string
  default = "random-name"
  description = "Name of the project"
  validation {
    condition = length(var.project_name) > 4
    error_message = "The Project name is too short."
  }
}