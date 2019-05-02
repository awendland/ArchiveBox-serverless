import json
from datetime import datetime

def handler(event, context):
    # TODO
    return {
        'statusCode': 200,
        'body': json.dumps({ 'test': datetime.now() })
    }
