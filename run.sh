# #!/bin/bash
for file in data/* executable ; do
  if [ -f "$file" ]; then
    rm "$file"
fi
done
python scripts/config.py
gfortran src/*F90 -o executable -llapack -g -O3
./executable

python scripts/unfold.py
