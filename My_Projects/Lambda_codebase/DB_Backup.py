import os
import boto3
import subprocess
from datetime import datetime

def lambda_handler(event, context):
    # Environment variables
    rds_instance_identifier = os.environ['RDS_INSTANCE_IDENTIFIER']
    s3_bucket_name = os.environ['S3_BUCKET_NAME']
    db_username = os.environ['DB_USERNAME']
    db_password = os.environ['DB_PASSWORD']
    db_name = os.environ['DB_NAME']

    # Generate timestamped filename
    timestamp = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    dump_file = f"/tmp/{rds_instance_identifier}_backup_{timestamp}.sql"
    compressed_file = f"{dump_file}.gz"

    # Create RDS database dump
    dump_command = [
        'mysqldump',
        f'--host={rds_instance_identifier}',
        f'--user={db_username}',
        f'--password={db_password}',
        db_name
    ]

    with open(dump_file, 'wb') as dump_output:
        subprocess.run(dump_command, stdout=dump_output, check=True)

    # Compress the dump file
    subprocess.run(['gzip', dump_file], check=True)

    # Upload to S3
    s3_client = boto3.client('s3')
    s3_client.upload_file(compressed_file, s3_bucket_name, os.path.basename(compressed_file))

    # Clean up local files
    os.remove(compressed_file)

    return {
        'statusCode': 200,
        'body': f"Backup of {db_name} completed and uploaded to {s3_bucket_name}."
    }