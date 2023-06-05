import yaml
from yaml.loader import SafeLoader
from loguru import logger
from models import Config

with open('config.yaml') as f:
    cf = yaml.load(f, Loader=SafeLoader)
    config = Config(**cf)
    logger.info(f"Config: {config}")
with open("data/config.in", "w") as f:
    s = "{}\t\t"*10
    f.write(s.format(config.l, config.n, config.t1, config.u1,
                     config.t2, config.u2, config.vr, config.vt,
                     config.ts, config.ws)
            )
    logger.info(f"translated")
