data "cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "env.cfg"
    content_type = "text/x-shellscript"
    content      = "${file("${path.module}/cloud_init/setup_env.sh")}"
  }
}
