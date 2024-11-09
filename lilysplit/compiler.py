import logging
from subprocess import PIPE, Popen, STDOUT

log = logging.getLogger(__name__)

class Compiler:
    popendict = dict(stdout=PIPE, stderr=STDOUT, text=True)
    lily_exe = None

    def __init__(self, song, lilycode, lilyopts):
        self.song = song
        self.sary = [self.lily_exe, *lilyopts, '-e', ' '.join(lilycode), song.path]
        self.returncode = None
        log.info("running %s", ' '.join([repr(str(x)) for x in self.sary]))

    def execute(self):
        lilyrun = Popen(self.sary, **self.popendict)
        for outline in lilyrun.stdout:
            print(outline, end='')
        self.returncode = lilyrun.wait()

