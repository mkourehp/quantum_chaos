import os
import numpy as np
from matplotlib import pyplot as plt
from unfold import Unfolding


def get_level_spacing_distro(plot: bool=False):
    energies, b, br = Unfolding(file_address=os.path.join(os.getcwd(), "data", "eigenenergies.dat"),
                                fit_poly_order=10, discard_percentage=20, err=False).unfold()
    spacings = np.diff(energies)
    if plot:
        plt.hist(spacings, bins="auto")
        plt.show()
    return b[0]


if __name__ == "__main__":
    get_level_spacing_distro()
