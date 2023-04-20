data "template_file" "setup_jh" {
  template = "${file("${path.module}/setup_jupyterhub.tpl")}"
  vars = {
    consul_address = "${aws_instance.consul.private_ip}"
  }
}



data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.setup_jh.rendered}"
  }
}