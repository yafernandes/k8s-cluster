data "aws_route53_zone" "pipsquack" {
  name = "aws.pipsquack.ca"
}

resource "aws_route53_record" "master" {
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "master.k8s"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_instance.master.public_dns]
}

resource "aws_route53_record" "worker" {
  count   = length(aws_instance.worker)
  zone_id = data.aws_route53_zone.pipsquack.zone_id
  name    = "worker${format("%02v", count.index)}.k8s"
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

output "workers" {
  value = aws_route53_record.worker[*].fqdn
}