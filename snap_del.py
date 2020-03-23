import boto3
import collections
import datetime
import math

client = boto3.client('ec2', region_name='us-east-1')


def lambda_handler(event, context):
    print("hi")

    snapshots = client.describe_snapshots(OwnerIds=['856130721258'])
    # print(snapshots)
    # def lambda_handler(event, context):
    for snapshot in snapshots['Snapshots']:
        now = datetime.datetime.today().strftime('%Y%m%d')
    print(now)
    current = int(now)

    retention = 90

    for snapshot in snapshots['Snapshots']:
        print("Checking snapshot %s which was created on %s" % (snapshot['SnapshotId'], snapshot['StartTime']))

    # Remove timezone info from snapshot in order for comparison to work below
    x = snapshot['StartTime'].strftime('%Y%m%d')
    print(x)
    snaptime = int(x)
    print(snaptime)
    z = (current - snaptime)
    print(z)
    if z > retention:
        print("The snapshot older than One day. Deleting Now")
        snapshots.delete_snapshot(SnapshotId=snapshot['SnapshotId'])
    else:
        print("Snapshot is newer than configured retention of %d days so we keep it" % (retention))
