from sys import argv
from json import loads

from yandex_tracker_client import TrackerClient

config = loads(argv[1])

client = TrackerClient(token=config["token"], org_id=config["org_id"])
issue = client.issues[config["ticket_id"]]

if config["action"] == "update_ticket":
    issue.update(**config["update"])
elif config["action"] == "add_comment":
    issue.comments.create(**config["comment"])
elif config["action"] == "clean_ticket":
    issue.update(
        summary="Кросс-проверка Инфраструктура — Кормановский Михаил",
        description=""
    )
    for comment in issue.comments:
        comment.delete()
else:
    print("unknown action")
    exit(1)
