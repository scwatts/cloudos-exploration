process INFO {
  debug true

  container 'docker.io/scwatts/aws-cli:2.17.18--noep'

  script:
  """
  echo --
  echo Dumping NF
  echo ${this.binding.variables.each {k,v -> println "$k = $v"}}
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
  """
}

workflow {
  INFO()
}
