#!/bin/bash

set -exuo pipefail

hugo
rsync -e 'ssh -i ~/.ssh/blog.pem' -rau ./public/ ubuntu@blog.schenck.online:/var/www/blog
