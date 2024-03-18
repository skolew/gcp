variable "ssh_keys" {
  type = list(object({
    publickey = string
    user = string
  }))
  description = "list of public ssh keys that have access to the VM"
  default = [
      {
        user = "skolev"
        publickey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILB9Kq9Kfp0De4x75Y4hCzQODA/FmU4nG/qRFgqQzOgh skolev@macbookpro"
      }
  ]
}
