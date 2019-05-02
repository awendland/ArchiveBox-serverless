# ⚠️ WIP ⚠️

Work in progress attempt to package [pirate/ArchiveBox](https://github.com/pirate/ArchiveBox) in a serverless manner, so that it can be run on AWS Lambda.

Currently, this will create a Docker image w/ all dependencies and source code located in `/package`. This will need to be zipped and sent to AWS Lambda.

Dependencies are handled in two manners, during Docker-build and during Lambda init.

Handled at Docker-build:
  * ArchiveBox's `Pipfile`
  * `wget`
  * `_sqlite3.so`

Handled at runtime:
  * `google-chrome-stable` (since it is >100MB)

## Misc. Notes

ArchiveBox (on `63abc89`) doesn't support Python 3.7 due to backwards incompatible changes to `types`.

## Current Issues

  * [ ] Django complains about needing SQLite 3.8.3, and the Lambda python3.6 runtime has 3.7.17
  * [ ] Zip `/package` to send to Lambda
  * [ ] Determine what the minimum set of ArchiveBox state to download from S3
  * [ ] Download last ArchiveBox state from S3
  * [ ] Upload updated ArchiveBox state back to S3
  * [ ] Limit Lambda concurrency to 1 at a time
  * [ ] Is Lambda the write platform to use (since it requires API Gateway) or should GCP be used?
  * [ ] Setup `serverless`/easy deploy script
