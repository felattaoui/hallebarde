from dataclasses import dataclass
from secrets import token_urlsafe
from uuid import uuid4
from datetime import datetime, timezone

@dataclass
class Exchange:
    identifier: str
    sub: str
    upload_token: str
    download_token: str
    revoked_upload: bool = False
    creation_time: datetime = datetime.now(timezone.utc)
    #email: str # mettre une regex par exple, se servir du package re : re.findall("[^\s()<>]+@[^\s()<>]+",content)

    @classmethod
    def generate(cls, sub: str):
        return cls(
            identifier=str(uuid4()),
            sub=sub,
            upload_token=token_urlsafe(32),
            download_token=token_urlsafe(32),
            revoked_upload=False
        )
