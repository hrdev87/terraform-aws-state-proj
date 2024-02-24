resource "aws_key_pair" "sshkey" {
  key_name = "app-key"
  public_key = file(var.PUB_KEY_PATH)
}