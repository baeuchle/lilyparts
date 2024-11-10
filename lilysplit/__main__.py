import sys
from .main import split

# manipulate sys.argv so that argparse doesn't report the script's name
# as __main__.py:
if sys.argv[0][-11:] == '__main__.py':
    sys.argv[0] = sys.argv[0][:-12]

split()
