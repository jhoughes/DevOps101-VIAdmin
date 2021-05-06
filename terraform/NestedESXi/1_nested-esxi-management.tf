provider “vsphere” {
  version=“~> 1.3”
  vsphere_server=“vcsa-01.home.local" #Change with your data
  allow_unverified_ssl=true
  user=“administrator@vsphere.local” #Change with your admin name and pwd
  password=“<my vCenter Server password>”
}

data “vsphere_datacenter” “dc” {
  name=“HOME” #The target dc
}

data “vsphere_resource_pool” “pool” {
  name=“Lab1”
  datacenter_id=“${data.vsphere_datacenter.dc.id}”
  }

data “vsphere_datastore” “datastore” {
  name=“vsanDatastore” #Change with your datastore name
  datacenter_id=“${data.vsphere_datacenter.dc.id}”
}

# Management interface
  data “vsphere_network” “network_mgmt” {
  name=“L1-ESXI-MGMT”
  datacenter_id=“${data.vsphere_datacenter.dc.id}”
}

####################################################################

data “vsphere_virtual_machine” “template” {
  name=“esxi-template”
  datacenter_id=“${data.vsphere_datacenter.dc.id}”
}

####################################################################
#L1-MGT-ESX-01
####################################################################

resource “vsphere_virtual_machine” “l1-mgt-esx-01” {
  name=“l1-mgt-esx-01.corp.local”
  guest_id=“${data.vsphere_virtual_machine.template.guest_id}”
  resource_pool_id=“${data.vsphere_resource_pool.pool.id}”
  datastore_id=“${data.vsphere_datastore.datastore.id}”
  num_cpus=2
  memory=20000
  wait_for_guest_net_timeout=0

  network_interface {
    network_id=“${data.vsphere_network.network_mgmt.id}”
  }
  network_interface {
    network_id=“${data.vsphere_network.network_mgmt.id}”
  }

  disk {
    label=“sda”
    unit_number=0
    size="${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub="${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned="${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  disk {
    label="sdb"
    unit_number=1
    size="${data.vsphere_virtual_machine.template.disks.1.size}"
    eagerly_scrub=“${data.vsphere_virtual_machine.template.disks.1.eagerly_scrub}"
    thin_provisioned="${data.vsphere_virtual_machine.template.disks.1.thin_provisioned}”
  }

  disk {
    label=“sdc”
    unit_number=2
    size=“${data.vsphere_virtual_machine.template.disks.2.size}”
    eagerly_scrub=“${data.vsphere_virtual_machine.template.disks.2.eagerly_scrub}”
    thin_provisioned=“${data.vsphere_virtual_machine.template.disks.2.thin_provisioned}”
  }

  clone {
     template_uuid=“${data.vsphere_virtual_machine.template.id}”
  }

  vapp {
    properties {
      “guestinfo.hostname” = “l1-mgt-esx-01”
      “guestinfo.ipaddress” = “192.168.12.11” # Default = DHCP
      “guestinfo.netmask” = “255.255.255.0”
      “guestinfo.gateway” = “192.168.12.1”
      “guestinfo.dns” = “192.168.11.10”
      “guestinfo.domain” = “lab1.local”
      “guestinfo.ntp” = “192.168.11.10”
      “guestinfo.syslog” = “”
      “guestinfo.password” = “VMware1!”
      “guestinfo.ssh” = “True” # Case-sensitive string
      “guestinfo.createvmfs” = “False” # Case-sensitive string
      “guestinfo.debug” = “False” # Case-sensitive string
    }
  }

  lifecycle {
    ignore_changes= [
      “annotation”,
      “vapp.0.properties”,
    ]
  }
}

####################################################################
#L1-MGT-ESX-02
####################################################################

resource “vsphere_virtual_machine” “l1-mgt-esx-02” {
  name=“l1-mgt-esx-02.corp.local”
  guest_id=“${data.vsphere_virtual_machine.template.guest_id}”
  resource_pool_id="${data.vsphere_resource_pool.pool.id}"
  datastore_id="${data.vsphere_datastore.datastore.id}"
  num_cpus=2
  memory=20000
  wait_for_guest_net_timeout=0

  network_interface {
    network_id="${data.vsphere_network.network_mgmt.id}"
  }
  network_interface {
    network_id="${data.vsphere_network.network_mgmt.id}"
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
    label=“sdc”
    unit_number=2
    size=“${data.vsphere_virtual_machine.template.disks.2.size}"
    eagerly_scrub="${data.vsphere_virtual_machine.template.disks.2.eagerly_scrub}”
    thin_provisioned=“${data.vsphere_virtual_machine.template.disks.2.thin_provisioned}”
  }

  clone {
     template_uuid=“${data.vsphere_virtual_machine.template.id}”
  }

  vapp {
    properties {
      “guestinfo.hostname” = “l1-mgt-esx-02”
      “guestinfo.ipaddress” = “192.168.12.12” # Default = DHCP
      “guestinfo.netmask” = “255.255.255.0”
      “guestinfo.gateway” = “192.168.12.1”
      “guestinfo.dns” = “192.168.11.10”
      “guestinfo.domain” = “lab1.local”
      “guestinfo.ntp” = “192.168.11.10”
      “guestinfo.syslog” = “”
      “guestinfo.password” = “VMware1!”
      “guestinfo.ssh” = “True” # Case-sensitive string
      “guestinfo.createvmfs” = “False” # Case-sensitive string
      “guestinfo.debug” = “False” # Case-sensitive string
    }
  }

  lifecycle {
    ignore_changes= [
      “annotation”,
      “vapp.0.properties”,
    ]
  }
}

####################################################################
#L1-MGT-ESX-03
####################################################################

resource “vsphere_virtual_machine” “l1-mgt-esx-03” {
  name=“l1-mgt-esx-03.corp.local”
  guest_id=“${data.vsphere_virtual_machine.template.guest_id}”
  resource_pool_id=“${data.vsphere_resource_pool.pool.id}”
  datastore_id=“${data.vsphere_datastore.datastore.id}”
  num_cpus=2
  memory=20000
  wait_for_guest_net_timeout=0

  network_interface {
    network_id="${data.vsphere_network.network_mgmt.id}"
  }
  network_interface {
    network_id="${data.vsphere_network.network_mgmt.id}"
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
    eagerly_scrub=“${data.vsphere_virtual_machine.template.disks.2.eagerly_scrub}"
    thin_provisioned="${data.vsphere_virtual_machine.template.disks.2.thin_provisioned}”
  }

  clone {
     template_uuid=“${data.vsphere_virtual_machine.template.id}”
  }

  vapp {
    properties {
      “guestinfo.hostname” = “l1-mgt-esx-03”
      “guestinfo.ipaddress” = “192.168.12.13” # Default = DHCP
      “guestinfo.netmask” = “255.255.255.0”
      “guestinfo.gateway” = “192.168.12.1”
      “guestinfo.dns” = “192.168.11.10”
      “guestinfo.domain” = “lab1.local”
      “guestinfo.ntp” = “192.168.11.10”
      “guestinfo.syslog” = “”
      “guestinfo.password” = “VMware1!”
      “guestinfo.ssh” = “True” # Case-sensitive string
      “guestinfo.createvmfs” = “False” # Case-sensitive string
      “guestinfo.debug” = “False” # Case-sensitive string
    }
  }

  lifecycle {
    ignore_changes= [
      “annotation”,
      “vapp.0.properties”,
    ]
  }
}
