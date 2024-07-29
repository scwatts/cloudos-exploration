process INFO {
  container 'docker.io/scwatts/aws-cli:2.17.18--conda'

  publishDir 'output/'

  output:
  path 'info.txt'

  script:
  """
  {
    echo --
    echo Dumping NF
    echo '${this.binding.variables.each {k,v -> println "$k = $v"}}'
    env
    echo --

    echo --
    echo IAM roles
    aws iam --no-verify-ssl list-roles
    echo --

    echo --
    echo IAM users
    aws iam --no-verify-ssl list-users
    echo --

    echo --
    echo Current role
    aws sts --no-verify-ssl get-caller-identity
    echo --
  } 2>&1 | tee info.txt
  """
}

workflow {
  INFO()

  [
    "/home/ec2-user/.nextflow/config",
    "/home/job/multidocker.config",
    "/home/job/aws.config",
    "/Users/stephen/repos/cloudos-exploration/nextflow.config",
  ]
    .each { dump_config(it) }

}

def dump_config(fp_str) {
  def fp = file(fp_str)

  println "---\n"
  if (fp.exists()) {
    print "found ${fp}"
    print fp.text
  } else {
    print "missing ${fp}"
  }
  println "---\n"
}
