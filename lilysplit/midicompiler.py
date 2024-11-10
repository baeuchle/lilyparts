__copyright__ = "© CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE"

from .compiler import Compiler

class MidiCompiler(Compiler):
    def __init__(self, song, lilycode, lilyopts, midi_suffix):
        lilyopts = lilyopts.copy()
        lilyopts.append('--ps')
        lilyopts.append(f'-dmidi-extension={midi_suffix[1:]}')
        lilycode = lilycode.copy()
        lilycode.append('(define-public makeMidi #t)')
        super().__init__(song, lilycode, lilyopts)

