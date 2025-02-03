terraform import aws_instance.web i-02459ebeafa25d947
terraform import aws_security_group.Test_SG sg-09bd7cc161211ceff


import {
  to = aws_instance.web
  id = "i-02459ebeafa25d947"
}

import {
  to = aws_security_group.Test_SG
  id = "sg-09bd7cc161211ceff"
}

