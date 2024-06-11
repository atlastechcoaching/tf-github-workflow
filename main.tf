// CREATE AN EC2 INSTANCE
resource "aws_instance" "vm1" {
  ami                    = "ami-08a0d1e16fc3f61ea"
  instance_type          = "t2.micro"

  tags = {
    Name = "test-github-action"
  }
}