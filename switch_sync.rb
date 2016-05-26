# synchronize taks to automatically sync between spreadsheet and site
# in development simply syncs the local files in github
require 'aws-sdk'

dest_path = ENV['NODE_ENV'] == 'production' || ENV['NODE_ENV'] == 'staging' ? '/tmp/locales' : './locales'
spreadsheet_key = "1One43VL0g3hP-FwHcq7GhqdSsQLzBZe-m-du_uUvZ7M"
result = `mkdir -p #{dest_path} && switch csv2json #{spreadsheet_key} #{dest_path}`
puts 'Successfully downloaded locale files'

exit 0 unless ENV['NODE_ENV'] == 'production' || ENV['NODE_ENV'] == 'staging'

puts 'Uploading to S3'

# uncomment for local testing
# ENV['AWS_ACCESS_KEY_ID'] = 'AK#############'
# ENV['AWS_SECRET_ACCESS_KEY']= 'A##########################'
# ENV['AWS_REGION'] = 'us-east-1'
# ENV['AWS_S3_BUCKET'] = 'hse-staging'

s3 = Aws::S3::Resource.new
Dir.glob('/tmp/locales/*.json') do |file|
  obj = s3.bucket(ENV['AWS_S3_BUCKET']).object("locales/#{File.basename(file)}")
  obj.upload_file(file, acl:'public-read')
end

puts 'Successfully uploaded files to s3'
