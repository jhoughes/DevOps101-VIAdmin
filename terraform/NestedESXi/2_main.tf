provider "vsphere" {
  version="~> 1.3"
  vsphere_server="vcsa.lab.fullstackgeek.net" #Change with your data
  allow_unverified_ssl=true
  user="administrator@vsphere.local" #Change with your admin name and pwd
  password="4Y7g9f1zN!"
}
data "vsphere_datacenter" "dc" {
  name="HomeLabWorkload" #The target dc
}

data "vsphere_resource_pool" "pool" {
  name="Resources"
  datacenter_id="${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "datastore" {
  name="datastore1" #Change with your datastore name
  datacenter_id="${data.vsphere_datacenter.dc.id}"
}

# Management interface
data "vsphere_network" "network_mgmt" {
  name="lablan"
  datacenter_id="${data.vsphere_datacenter.dc.id}"
}

# SAN interface
data "vsphere_network" "network_san" {
  name="naslan"
  datacenter_id="${data.vsphere_datacenter.dc.id}"
}

#Template
data "vsphere_virtual_machine" "template" {
  name="Nested_ESXi6.0u3_Appliance_Template_v1.0"
  datacenter_id="${data.vsphere_datacenter.dc.id}"
}


#Define new nested ESXi hosts
resource "vsphere_virtual_machine" "esxi1" {
  name="esxi31.linoproject.lab"
  guest_id="${data.vsphere_virtual_machine.template.guest_id}"
  resource_pool_id="${data.vsphere_resource_pool.pool.id}"
  datastore_id="${data.vsphere_datastore.datastore.id}"
  folder="NestedESXi60"
  num_cpus=2
  memory=6144
  wait_for_guest_net_timeout=0

  network_interface {
    network_id="${data.vsphere_network.network_mgmt.id}"
  }
  network_interface {
    network_id="${data.vsphere_network.network_san.id}"
  }

  disk {
    label="sda"
    unit_number=0
    size="${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub="${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned="${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  disk {
    label="sdb"
    unit_number=1
    size="${data.vsphere_virtual_machine.template.disks.1.size}"
    eagerly_scrub="${data.vsphere_virtual_machine.template.disks.1.eagerly_scrub}"
    thin_provisioned="${data.vsphere_virtual_machine.template.disks.1.thin_provisioned}"
  }

  disk {
    label="sdc"
    unit_number=2
    size="${data.vsphere_virtual_machine.template.disks.2.size}"
    eagerly_scrub="${data.vsphere_virtual_machine.template.disks.2.eagerly_scrub}"
    thin_provisioned="${data.vsphere_virtual_machine.template.disks.2.thin_provisioned}"
  }

  clone {
     template_uuid="${data.vsphere_virtual_machine.template.id}"
  }

  vapp {
    properties {
      "guestinfo.hostname" = "esxi31"
      "guestinfo.ipaddress" = "192.168.200.31" # Default = DHCP
      "guest info.netmask" = "255.255.255.0"
      "guestinfo.gateway" = "192.168.200.254"
      "guestinfo.vlan" = ""
      "guestinfo.dns" = "192.168.200.10"
      "guestinfo.domain" = "linoproject.lab"
      "guestinfo.ntp" = "pool.ntp.org"
      "guestinfo.syslog" = ""
      "guestinfo.password" = "xxxxxx"
      "guestinfo.ssh" = "True" # Case-sensitive string
      "guestinfo.createvmfs" = "False" # Case-sensitive string
      "guestinfo.debug" = "False" # Case-sensitive string
    }
  }

  lifecycle {
    ignore_changes= [
      "annotation",
      "vapp.0.properties",
    ]
  }
}