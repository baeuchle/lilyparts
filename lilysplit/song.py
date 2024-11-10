__copyright__ = "© CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE"

from pathlib import Path

class LilySong:
    def __init__(self, path):
        self.voices = []
        self.path = self.correct_file(path)
        self.stem = self.path.stem
        self.directory = self.path.parent

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        for patt in ('*midirm', '*-midi.ps', '*-tmp-*'):
            for f in Path('.').glob(self.stem + patt):
                f.unlink(missing_ok=True)

    def __str__(self):
        return str(self.stem)

    def correct_file(self, path):
        if path.is_dir():
            path = path.with_suffix('.ly')
        if not path.exists(): # now what?
            raise AttributeError(f"Cannot open {path}")
        with path.open('r') as peek:
            for line in peek:
                if not line.strip():
                    continue
                if line[:28] == r'\include "lilyparts/head.ly"':
                    self.read_voices(peek)
                    return path
        return self.correct_file(path.parent)

    def read_voices(self, peek):
        for line in peek:
            if "calc.ly" in line:
                return
            words = line.strip().split()
            if words and words[0][:3] == 'has':
                self.voices.append(words[0][3:])

    def move(self, voice, suffix):
        source = Path(self.stem + voice).with_suffix(suffix)
        if not source.exists():
            return
        source.rename(Path(self.stem).with_suffix(suffix))

