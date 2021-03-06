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
    email: str
    revoked_upload: bool = False
    creation_time: datetime = datetime.now(timezone.utc)


    @classmethod
    def generate(cls, sub: str, email: str):
        return cls(
            identifier=str(uuid4()),
            sub=sub,
            upload_token=token_urlsafe(32),
            download_token=token_urlsafe(32),
            revoked_upload=False,
            email=email
        )

