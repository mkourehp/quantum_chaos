import yaml
from yaml.loader import SafeLoader
from loguru import logger
from models import Config


def get_config() -> Config:
    with open('config.yaml') as f:
        cf = yaml.load(f, Loader=SafeLoader)
        config = Config(**cf)
    return config


def translate_config_for_fortran(config: Config):
    with open("data/config.in", "w") as f:
        s = "{}\t\t"*10
        f.write(s.format(config.l, config.n, config.t1, config.u1,
                         config.t2, config.u2, config.vr, config.vt,
                         config.ts, config.ws)
                )
        logger.success("translated.")


if __name__ == "__main__":
    get_config()
