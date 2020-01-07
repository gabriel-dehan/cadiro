CarrierWave.configure do |config|
  config.storage    =  :aws
  config.aws_bucket =  'path-of-economy-v1'
  # config.aws_acl    =  :public_read

  config.aws_credentials = {
    access_key_id:      ENV['S3_KEY'],
    secret_access_key:  ENV['S3_SECRET'],
    region: 'eu-west-1'
  }                
end