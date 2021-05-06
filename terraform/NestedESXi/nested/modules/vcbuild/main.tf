variable "vcentername" {
  description = "vcenter name"
  default = "myvcenter"
}

variable "vcpassword" {
  description = "vcpassword"
  default = "Pa55w0rd123!!"
}

variable "esxipassword" {
  description = "esxi password"
  default = "Pa55w0rd999!"
}

variable "vcip" {
  description = "ip address"
  default = "192.168.1.100"
}

variable "dnsserver" {
  description = "dns server"
  default = "192.168.1.101"
}

variable "ipprefix" {
  description = "prefix"
  default = "24"
}

variable "gateway" {
  description = "gateway"
  default = "192.168.1.1"
}

variable "vchostname" {
  description = "vc hostname"
  default = "mycenter.test.local"
}

data "template_file" "task" {
  template = "${file("c:\files\vcsatemplate.json")}"

  vars {
    vcname = "${var.vcentername}"
    esxipassword = "${var.esxipassword}"
    vcpassword = "${var.vcpassword}"
    vchostname = "${var.vchostname}"
    ipaddress = "${var.vcip}"
    dnsserver = "${var.dnsserver}"
    ipprefix = "${var.ipprefix}"
    gateway = "${var.gateway}"
  }
}
resource "local_file" "foo" {
  content     = "${data.template_file.task.rendered}"
  filename = "c:\files\vctemplate.json"
}

resource "null_resource" "vc" {
  provisioner "local-exec" {
    command = "c:\files\VMware-VCSA-all-6.7.0-8217866/vcsa-cli-installer/win32/vcsa-deploy.exe install --accept-eula --acknowledge-ceip --terse --no-ssl-certificate-verification c:\files\vctemplate.json"
  }
}