# Add an elastic ip for the jump-box, the rest of the instances don't reallyr equire it because you can just jump from the jump box via privat eIP
# THIS IS OPTIONAL: if you do not want to pay for an EIP make sure to disable this. This is useful if you want to start and stop your instances and avoid having to redo your SSH config every time.
resource "aws_eip" "jump-box_eip" {
  instance = aws_instance.jump-box.id
  domain   = "vpc"
  depends_on = [aws_internet_gateway.khw-internet-gateway]
  tags = {
    Name: "jump-box elastic ip"
  }
}
