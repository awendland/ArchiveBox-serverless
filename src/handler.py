# Setup path to binaries and installed files
import os, sys
os.environ['PYTHONPATH'] = '/package/pylibs'
sys.path.append('/package/bin')
sys.path.append('/package/pylibs/bin')

# Download Google Chrome
import brotli
import urllib.request
def download_uncompress(url, dest):
    print('Downloading {}'.format(url))
    with urllib.request.urlopen(url) as response:
        data = brotli.decompress(response.read())
        print('Extracted to {} bytes'.format(len(data)))
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        with open(dest, 'wb+') as file:
            file.write(data)
            print('Decompressed to {}'.format(dest))
download_uncompress('https://raw.githubusercontent.com/alixaxel/chrome-aws-lambda/master/bin/chromium-75.0.3765.0.br', '/tmp/chromium')
download_uncompress('https://raw.githubusercontent.com/alixaxel/chrome-aws-lambda/master/bin/swiftshader/libGLESv2.so.br', '/tmp/swiftshader/libEGL.so')
download_uncompress('https://raw.githubusercontent.com/alixaxel/chrome-aws-lambda/master/bin/swiftshader/libEGL.so.br', '/tmp/swiftshader/libGLESv2.so')
os.environ['CHROME_BINARY'] = '/tmp/chromium'

# Handle requests
def handler():
    # Download files from S3
    # Do ArchiveBox stuff
    # Upload files back to S3
    pass
