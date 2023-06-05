import os
import numpy as np
from matplotlib import pyplot as plt
from scripts.unfold import Unfolding


def get_level_spacing_distro(path="data/unfolded_spectrum.txt"):
    energies, b, br = Unfolding(file_address=os.path.join(os.getcwd(), "data", "eigenenergies.dat"),
                                fit_poly_order=10, discard_percentage=20, err=False).unfold()
    spacings = np.diff(energies)
    print(f"Brody Parameter: ", b)
    plt.hist(spacings, bins="auto")
    plt.show()


if __name__ == "__main__":
    get_level_spacing_distro()
