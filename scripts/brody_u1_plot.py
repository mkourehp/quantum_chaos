import numpy as np
from typing import List
from level_spacing_distro import get_level_spacing_distro
from config import get_config, translate_config_for_fortran
from utilities import compile_and_execute
from matplotlib import pyplot as plt


def u1_b_plot(u1, b):
    plt.plot(u1, b, "o")
    plt.xlabel("Bath particles interaction strength u1")
    plt.ylabel("Chaoticity measure, Brody parameter b")
    plt.show()


def u1_brody_plot(u1_min, u1_max, u1_steps, plot: bool=True):
    u1_b = []
    for u1 in np.linspace(u1_min, u1_max, u1_steps):
        config = get_config()
        config.u1 = u1
        translate_config_for_fortran(config=config)
        compile_and_execute()
        b = get_level_spacing_distro()
        u1_b.append([u1, b])
    if plot:
        u1_b_plot([l[0] for l in u1_b], [l[1] for l in u1_b])
    return u1_b


if __name__ == "__main__":
    u1_brody_plot(0, 1, 20, plot=True)
