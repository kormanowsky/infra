from sys import argv
from json import loads

from yandex_tracker_client import TrackerClient

print("Reading sync config")
config = loads(argv[1])

print("Creating tracker client")
client = TrackerClient(token=config["token"], org_id=config["org_id"])

print("Fetching tracker issue")
issue = client.issues[config["ticket_id"]]

if config["action"] == "update_ticket":
    print("Updating tracker issue")
    issue.update(**config["update"])
elif config["action"] == "add_comment":
    print("Sending new comment")
    issue.comments.create(**config["comment"])
elif config["action"] == "clean_ticket":
    print("Cleaning tracker issue")
    issue.update(
        summary="Кросс-проверка Инфраструктура — Кормановский Михаил",
        description=""
    )
    for comment in issue.comments:
        comment.delete()
else:
    print("Unknown action")
    exit(1)
