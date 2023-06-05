from dataclasses import dataclass
from loguru import logger

@dataclass
class Config:
    l: int
    n: int
    u1: float = 0.0
    t1: float = -1.0
    u2: float = 0.0
    t2: float = 0.0
    vr: float = 0.00
    vt: str = "L"
    ts: float = 1.0
    ws: float = 0.0
