data "aws_route53_zone" "pipsquack" {
  name = "aws.pipsquack.ca"
}

resource "aws_route53_record" "master" {
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "${aws_instance.master.tags.dns_name}.${var.cluster_name}"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_instance.master.public_dns]
}

resource "aws_route53_record" "worker" {
  count   = length(aws_instance.worker)
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "${aws_instance.worker[count.index].tags.dns_name}.${var.cluster_name}"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_instance.worker[count.index].public_dns]
}

resource "aws_route53_record" "dashboard" {
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "dashboard.${var.cluster_name}"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_instance.master.public_dns]
}

resource "aws_route53_record" "proxy" {
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "${aws_instance.proxy.tags.dns_name}.${var.cluster_name}"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_instance.proxy.public_dns]
}

resource "aws_route53_record" "nginx" {
  count   = length(aws_instance.worker)
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "nginx.${var.cluster_name}"
  type    = "CNAME"
  ttl     = "60"
  weighted_routing_policy {
    weight = 10
  }
  set_identifier = aws_instance.worker[count.index].id
  records = [aws_instance.worker[count.index].public_dns]
}

resource "aws_route53_record" "jenkins" {
  count   = length(aws_instance.worker)
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "jenkins.${var.cluster_name}"
  type    = "CNAME"
  ttl     = "60"
  weighted_routing_policy {
    weight = 10
  }
  set_identifier = aws_instance.worker[count.index].id
  records = [aws_instance.worker[count.index].public_dns]
}
