data "aws_route53_zone" "pipsquack" {
  name = var.domain
}

resource "aws_route53_record" "master" {
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "${aws_instance.master.tags.dns_name}.k8s"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_instance.master.public_dns]
}

resource "aws_route53_record" "worker" {
  count   = length(aws_instance.worker)
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "${aws_instance.worker[count.index].tags.dns_name}.k8s"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_instance.worker[count.index].public_dns]
}

resource "aws_route53_record" "dashboard" {
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "dashboard.k8s"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_instance.master.public_dns]
}

resource "aws_route53_record" "proxy" {
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "${aws_instance.proxy.tags.dns_name}.k8s"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_instance.proxy.public_dns]
}

resource "aws_route53_record" "nginx" {
  count   = length(aws_instance.worker)
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "nginx.k8s"
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
  name    = "jenkins.k8s"
  type    = "CNAME"
  ttl     = "60"
  weighted_routing_policy {
    weight = 10
  }
  set_identifier = aws_instance.worker[count.index].id
  records = [aws_instance.worker[count.index].public_dns]
}
