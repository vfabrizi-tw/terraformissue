resource "aws_security_group" "sg_i-stack" {
    name = "sg_i-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
    vpc_id = "${var.vpcID}" 

    tags {   
        "Name" = "sg-i-${var.project_name}-${var.project_name}-${var.environment}-${var.uuid}" 
    }

    tags {   
        "Id" = "sg-i-${var.project_name}-${var.project_name}-${var.environment}-${var.uuid}" 
    }

    tags {   
        "Service" = "${var.service_name}"
    }

    tags {   
        "Project" = "${var.project_name}"
    }

    tags {   
        "Environment" = "${var.environment}"
    }

    tags {   
        "Uuid" = "${var.uuid}"
    }

}

resource "aws_security_group_rule" "sg_i-ingress" {
    type = "ingress"
    from_port = "${var.i_sg_ports[count.index]}" 
    to_port = "${var.i_sg_ports[count.index]}"
    protocol = "tcp"
    cidr_blocks = ["${var.vpcCIDR}"] 
    security_group_id = "${aws_security_group.sg_i-stack.id}" 
    count = "${length(var.i_sg_ports)}"
}

resource "aws_security_group_rule" "sg_i-egrees" {
    type = "egress"
    from_port = "0" 
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
    security_group_id = "${aws_security_group.sg_i-stack.id}" 
}


resource "aws_security_group" "sg_elb-stack" {
    name = "sg_elb-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
    vpc_id = "${var.vpcID}"

    tags {   
        "Name" = "sg-i-${var.project_name}-${var.project_name}-${var.environment}-${var.uuid}" 
    }

    tags {
        "Id" = "sg-elb-${var.project_name}-${var.project_name}-${var.environment}-${var.uuid}"
    }

    tags {
        "Service" = "${var.service_name}"
    }

    tags {
        "Project" = "${var.project_name}"
    }

    tags {
        "Environment" = "${var.environment}"
    }

    tags {   
        "Uuid" = "${var.uuid}"
    }

}

resource "aws_security_group_rule" "sg_elb-ingress" {
    type = "ingress"
    from_port = "${var.elb_sg_ports[count.index]}" 
    to_port = "${var.elb_sg_ports[count.index]}"
    protocol = "tcp"
    cidr_blocks = ["${var.elb_sg_open_cidr}"] 
    security_group_id = "${aws_security_group.sg_elb-stack.id}" 
    count = "${length(var.elb_sg_ports)}"
}

resource "aws_security_group_rule" "sg_elb-egrees" {
    type = "egress"
    from_port = "0" 
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
    security_group_id = "${aws_security_group.sg_elb-stack.id}" 
}
